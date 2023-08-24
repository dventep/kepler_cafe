from datetime import date, timedelta, datetime, time
import pytz, traceback

from django.db.models import F, Func, Value, CharField
from django.contrib.auth.hashers import make_password
from django.shortcuts import render, redirect
from django.db.models import F
from django.http import HttpResponse, JsonResponse
from django.utils.timezone import make_aware, utc
from django.contrib.auth.decorators import login_required

from .models import Shopping_Car, Main_Purchase, Purchase_Detail, Point_Transaction
from Inventory.models import Product

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

def look_product_shopping_car(request):
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
