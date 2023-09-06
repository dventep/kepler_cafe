from datetime import date, timedelta, datetime, time
import pytz, traceback

from django.db.models import F, Func, Value, CharField
from django.contrib.auth.hashers import make_password
from django.shortcuts import render, redirect
from django.db.models import F
from django.http import HttpResponse, JsonResponse
from django.utils.timezone import make_aware, utc
from django.contrib.auth.decorators import login_required

from .models import UserProfile, Charge
from Movement.models import Shopping_Car

def home(request):
    shopping_car_quantity = 0
    if  request.user and request.user.is_authenticated:
        shopping_car_quantity = Shopping_Car.objects.filter(user_id = request.user.identification).count()
    return render(request, "index.html", {'shopping_car_quantity': shopping_car_quantity})

def validate_register(identification_validate, errors_list, identification, first_name, last_name, email, password, phone_number, birth_date, updating = False):
    """
        Description:
            This function has the objective of validate whether datas gotten are right or not. 
    """
    if not identification or identification == "":
        errors_list.append({ 'title': 'Identificación del usuario', 'content': 'Debe ingresar su identificación.' })
    elif not identification.isdigit():
        errors_list.append({ 'title': 'Identificación del usuario', 'content': 'Debe ingresar solo números en la identificación.' })
    if not first_name or first_name == "":
        errors_list.append({ 'title': 'Nombres del usuario', 'content': 'Debe ingresar sus nombres.' })
    if not last_name or last_name == "":
        errors_list.append({ 'title': 'Apellidos del usuario', 'content': 'Debe ingresar sus apellidos.' })
    if not email or email == "":
        errors_list.append({ 'title': 'Correo electrónico del usuario', 'content': 'Debe ingresar su correo electrónico.' })
    elif not "@" in email:
        errors_list.append({ 'title': 'Correo electrónico del usuario', 'content': 'Debe ingresar un correo electrónico válido.' })
    elif UserProfile.objects.filter(email = email).exists():
        if not updating or (not UserProfile.objects.filter(identification = identification_validate, email = email).exists()):
            errors_list.append({ 'title': 'Correo electrónico del usuario', 'content': 'Ya existe una cuenta con ese correo.' })
    if not phone_number or phone_number == "":
        errors_list.append({ 'title': 'Número de contacto del usuario', 'content': 'Debe ingresar un número de contacto.' })
    elif not phone_number.isdigit():
        errors_list.append({ 'title': 'Número de contacto del usuario', 'content': 'Debe ingresar un número de contacto válido.' })
    if not password or password == "":
        errors_list.append({ 'title': 'Contraseña del usuario', 'content': 'Debe ingresar una contraseña.' })
    if not birth_date or birth_date == "":
        errors_list.append({ 'title': 'Fecha de nacimiento', 'content': 'Debe ingresar la fecha de nacimiento.' })
        
    return errors_list

def register_html(request):
    """
        Description:
            This function has the objective to get the template to register and create the client record. 
    """
    return_content = {}
    return_errors = []
    identification = request.POST.get("identification", "")
    first_name = request.POST.get('first_name', '')
    last_name = request.POST.get('last_name', '')
    email = request.POST.get('email', '')
    password = request.POST.get('password', '')
    phone_number = request.POST.get('phone_number', '')
    birth_date = request.POST.get('birth_date', '')
    datetime_tz = datetime.now(tz=pytz.timezone('America/Bogota'))
    if request.POST:
        return_errors = validate_register(identification_validate=identification, errors_list=return_errors, identification=identification, first_name=first_name, last_name=last_name, email=email, password=password, phone_number=phone_number, birth_date=birth_date)
        return_content['errors'] = return_errors
        # print("return_content:", return_content)
        if len(return_errors) == 0:
            user = UserProfile(
                identification = identification,
                first_name = first_name,
                last_name = last_name,
                email = email,
                # password = make_password(password),
                phone_number = phone_number,
                creation_date = datetime_tz,
                entrance_date = datetime_tz,
                birth_date = birth_date,
            )
            user.set_password(password)
            user.save()
            return redirect('/accounts/login')
        
    return_content["identification"] = request.POST.get("identification", "")
    return_content["first_name"] = request.POST.get('first_name', '')
    return_content["last_name"] = request.POST.get('last_name', '')
    return_content["email"] = request.POST.get('email', '')
    return_content["password"] = request.POST.get('password', '')
    return_content["phone_number"] = request.POST.get('phone_number', '')
    return_content["birth_date"] = request.POST.get('birth_date', '')
    datetime_tz = datetime.now(tz=pytz.timezone('America/Bogota'))

    return render(request, 'registration/signup.html', return_content)

def update_user(identification_user, identification, first_name, last_name, email, password, phone_number, errors_list):
    """
        Description:
            This function has the objective to update the data about a specific user. 
    """
    try:
        user = UserProfile.objects.get(identification = identification_user)
        user.identification = identification
        user.first_name = first_name
        user.last_name = last_name
        user.email = email
        user.set_password(password)
        user.phone_number = phone_number
        user.save()
    except:
        errors_list.append({
            'title': 'Error al actualizar perfil',
            'content': f'Se presentó el error: {traceback.format_exc()}'
        })
    return errors_list

@login_required
def manage_profile(request):
    """
        Description:
            This function has the objective to get the template to edit his data and update him. 
    """
    return_content = {'errors': [], 'message': {}}
    return_errors = []
    
    if request.POST:
        identification = str(request.user.identification)
        first_name = request.POST.get('first_name', '')
        last_name = request.POST.get('last_name', '')
        email = request.POST.get('email', '')
        password = request.POST.get('password', '')
        phone_number = request.POST.get('phone_number', '')

        return_errors = validate_register(identification_validate=identification, errors_list=return_errors, identification=identification, first_name=first_name, last_name=last_name, email=email, password=password, phone_number=phone_number, birth_date="NoApply", updating=True)
        return_content['errors'] = return_errors
        
        if len(return_errors) == 0:
            return_errors = update_user(request.user.identification, identification, first_name, last_name, email, password, phone_number, return_errors)

        if len(return_errors) == 0:
            return_content['message'] = {
                'title': 'Actualización exitosa',
                'content': 'Se ha actualizado usuario con éxito.'
            }
        else:
            return_content['message'] = {
                'title': 'Actualización interrumpida',
                'content': 'Se han presentado problemas en la actualización.'
            }   
    return_content['errors'] = return_errors
    shopping_car_quantity = 0
    if  request.user and request.user.is_authenticated:
        shopping_car_quantity = Shopping_Car.objects.filter(user_id = request.user.identification).count()
    if request.user.is_staff or request.user.is_superuser:
        return_content['charge_list'] = list(Charge.objects.all().values('pk', 'name').order_by('name', 'pk'))
    return_content['shopping_car_quantity'] = shopping_car_quantity
    return render(request, 'user/user.html', return_content)

def terms_and_conditions(request):
    """
        Description:
            This function has the objective to get the template to edit his data and update him. 
    """
    return_content = {'errors': [], 'message': {}}
    return_errors = []
    return_content['errors'] = return_errors

    shopping_car_quantity = 0
    if  request.user and request.user.is_authenticated:
        shopping_car_quantity = Shopping_Car.objects.filter(user_id = request.user.identification).count()
    return_content['shopping_car_quantity'] = shopping_car_quantity
    
    return render(request, 'user/terms_and_conditions.html', return_content)
