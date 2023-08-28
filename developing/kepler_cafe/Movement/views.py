from datetime import date, timedelta, datetime, time
import pytz, traceback

from django.db.models import F, Func, Value, CharField
from django.contrib.auth.hashers import make_password
from django.shortcuts import render, redirect
from django.db.models import F
from django.http import HttpResponse, JsonResponse
from django.utils.timezone import make_aware, utc
from django.contrib.auth.decorators import login_required
from django.template.loader import get_template
from django.core.mail import EmailMultiAlternatives
from django.conf import settings

from .models import Shopping_Car, Main_Purchase, Purchase_Detail, Point_Transaction
from Inventory.models import Product
from User.models import UserProfile

def add_product_shopping_car(request):
    return_content = {'errors': [], 'shopping_car_quantity': 0}
    return_errors = []
    if not (request.user and request.user.is_authenticated):
        return_errors.append({ 'title': 'Iniciar sesión', 'content': 'Debes iniciar sesión para añadir al carrito.' })
    else:
        if request.POST and request.POST.get('product_id', False) and request.POST.get('quantity', False):
            product_id = request.POST.get('product_id', False)
            quantity = request.POST.get('quantity', False)
            description = request.POST.get('description', '')
            if description == '':
                description = None
            if not Product.objects.filter(pk = product_id).exists():
                return_errors.append({ 'title': 'Producto', 'content': f'El producto con Identificación {product_id} no existe.' })
            elif not Product.objects.filter(pk = product_id, quantity__gte = quantity).exists():
                return_errors.append({ 'title': 'Cantidad del Producto', 'content': f'El producto elegido no tiene la cantidad solicitada.' })
            else:
                Shopping_Car.objects.create(
                    quantity = quantity,
                    creation_date = datetime.now(tz=pytz.timezone('America/Bogota')),
                    description = description,
                    user = request.user,
                    product_id = product_id
                )
        else:
            return_errors.append({ 'title': 'Adición a carrito', 'content': 'No se ha podido añadir al carrito debido a que no tiene la información completa.' })
        return_content['shopping_car_quantity'] = Shopping_Car.objects.filter(user_id = request.user.pk).count()
        return_content['errors'] = return_errors
    return JsonResponse(return_content)

def remove_product_shopping_car(request):
    return_content = {'errors': [], 'shopping_car_quantity': 0}
    return_errors = []
    if not (request.user and request.user.is_authenticated):
        return_errors.append({ 'title': 'Iniciar sesión', 'content': 'Debes iniciar sesión para añadir al carrito.' })
    else:
        if request.POST and request.POST.get('shopping_car_id', False):
            shopping_car_id = request.POST.get('shopping_car_id', False)
            if not Shopping_Car.objects.filter(pk = shopping_car_id).exists():
                return_errors.append({ 'title': 'Producto del carrito', 'content': f'No existe el producto seleccionado con Identificación {shopping_car_id}.' })
            else:
                Shopping_Car.objects.filter(pk = shopping_car_id).delete()
        else:
            return_errors.append({ 'title': 'Adición a carrito', 'content': 'No se ha podido remover el producto del carrito debido a que no se recibió la información completa.' })
        return_content['shopping_car_quantity'] = Shopping_Car.objects.filter(user_id = request.user.pk).count()
        return_content['errors'] = return_errors
    return JsonResponse(return_content)

def send_check_email(request, shopping_car_list, money_total_value, point_total_value, order_purchase):
    template = get_template("movement/email_check/send.html")
    content = template.render({
        'request': request,
        'shopping_car_list': shopping_car_list,
        'money_total_value': money_total_value,
        'point_total_value': point_total_value,
        'order_purchase': order_purchase
    })
    msg = EmailMultiAlternatives(
        'Gracias por tu compra - Kepler',
        'Hola, te enviamos un correo con tu factura',
        settings.EMAIL_HOST_USER,
        [request.user.email]
    )
    msg.attach_alternative(content, 'text/html')
    msg.send()
    return True

def make_purchasing(request):
    use_points = request.POST['use_points']
    errors_list = []
    money_total_value = 0
    point_total_value = 0
    shopping_car_list = Shopping_Car.objects.filter(user__pk = request.user.pk).values('pk','product__name', 'product__pk', 'quantity', 'description', 'product__money_unit_price', 'product__point_unit_price', money_total_price = F('product__money_unit_price') * F('quantity'), point_total_price = F('product__point_unit_price') * F('quantity'))
    creation_date = datetime.now(tz=pytz.timezone('America/Bogota'))
    if len(shopping_car_list) > 0:
        main_purchase = Main_Purchase.objects.create(
            creation_date = creation_date,
            user_id = request.user.pk
        )
        for shopping_car in shopping_car_list:
            if shopping_car['quantity'] > 0:
                total_points = UserProfile.objects.get(pk = request.user.pk).point
                points_to_purchase = None
                money_to_purchase = None
                money_unit_to_purchase = None
                point_unit_to_purchase = None
                
                # Validación para saber si compró con puntos o no
                if use_points and total_points >= shopping_car['point_total_price']:
                    points_to_purchase = shopping_car['point_total_price']
                    total_points -= points_to_purchase
                    UserProfile.objects.filter(pk = request.user.pk).update(point = total_points)
                    point_unit_to_purchase = shopping_car['product__point_unit_price']
                else:
                    money_to_purchase = shopping_car['money_total_price']
                    money_unit_to_purchase = shopping_car['product__money_unit_price']
                # Creación del detalle de compra
                purchase_detail = Purchase_Detail.objects.create(
                    money_unit_value = money_unit_to_purchase,
                    point_unit_value = point_unit_to_purchase,
                    quantity = shopping_car['quantity'],
                    description = shopping_car['description'],
                    status = 'waiting',
                    main_purchase = main_purchase,
                    product_id = shopping_car['product__pk']
                )

                point_total_value += points_to_purchase if points_to_purchase != None else 0
                money_total_value += money_to_purchase if money_to_purchase != None else 0
                # Transacción de puntos
                if points_to_purchase: # Si compró con puntos
                    Point_Transaction.objects.create(
                        quantity_point = shopping_car['point_total_price'],
                        action = 'out',
                        transaction_date = creation_date,
                        purchase_detail = purchase_detail
                    )
                quantity_point = 5 * shopping_car['quantity']
                Point_Transaction.objects.create(  # Puntos que recibe por comprar
                    quantity_point = quantity_point,
                    action = 'in',
                    transaction_date = creation_date,
                    purchase_detail = purchase_detail
                )
                UserProfile.objects.filter(pk = request.user.pk).update(point = total_points + quantity_point)
        # Actualización de los valores de la compra principal.
        main_purchase.money_total_value = money_total_value
        main_purchase.point_total_value = point_total_value
        main_purchase.save()
        
        # Crear factura:
        send_check_email(request, Purchase_Detail.objects.filter(main_purchase_id = main_purchase.pk).values(
            "main_purchase__pk",
            "quantity",
            "money_unit_value",
            "point_unit_value",
            "product__name",
            money_total_price = F('money_unit_value') * F('quantity'),
            point_total_price = F('point_unit_value') * F('quantity')),
        money_total_value, point_total_value, main_purchase.pk)
        Shopping_Car.objects.filter(user__pk = request.user.pk).delete()
    else:
        errors_list.append({ 'title': 'Compra no realizada', 'content': 'No hay productos que comprar.' })
    return errors_list

def look_product_shopping_car(request):
    return_content = {'errors': [], 'shopping_car_quantity': 0}
    return_errors = []
    if not (request.user and request.user.is_authenticated):
        return_errors.append({ 'title': 'Iniciar sesión', 'content': 'Debes iniciar sesión para tener un carrito.' })
    else:
        return_content['shopping_car_quantity'] = Shopping_Car.objects.filter(user_id = request.user.pk).count()
        if request.POST:
            if not request.POST.get('use_points', False):
                return_errors.append({ 'title': 'Indicador de uso de puntos', 'content': 'No se recibió el indicador de uso de puntos.' })
            else:
                return_errors += make_purchasing(request)
                if len(return_errors) == 0:
                    return render(request, 'inventory/products_shop.html', context=return_content)
        if len(return_errors) == 0:
            if not Shopping_Car.objects.filter(user = request.user.pk).exists():
                shopping_car_list = []
                return_content['shopping_car_quantity'] = 0
            else:
                shopping_car_list = Shopping_Car.objects.filter(user__pk = request.user.pk).values(
                    'pk',
                    name_product = F('product__name'),
                    quantity_shopping_car = F('quantity'),
                    money_unit_price = F('product__money_unit_price'),
                    money_total_price = F('product__money_unit_price') * F('quantity'),
                    point_unit_price = F('product__point_unit_price'),
                    point_total_price = F('product__point_unit_price') * F('quantity'),
                    use_points = Value(False),
                    image_product = F('product__image_product'),
                )
                return_content['shopping_car_quantity'] = Shopping_Car.objects.filter(user_id = request.user.pk).count()
        return_content['shopping_car_list'] = shopping_car_list
    return_content['errors'] = return_errors
    # return JsonResponse(return_content, safe=False, json_dumps_params={'ensure_ascii': False})
    return render(request, 'movement/shopping_car.html', context=return_content)
