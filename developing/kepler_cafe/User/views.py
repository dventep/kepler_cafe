from datetime import date, timedelta, datetime, time
import pytz

from django.contrib.auth.hashers import make_password
from django.shortcuts import render, redirect
from django.http import HttpResponse, JsonResponse
from django.utils.timezone import make_aware, utc
from django.contrib.auth.decorators import login_required

from .models import UserProfile, Charge

def validate_register(errors_list, identification, first_name, last_name, email, password, phone_number):
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
    if not phone_number or phone_number == "":
        errors_list.append({ 'title': 'Número de contacto del usuario', 'content': 'Debe ingresar un número de contacto.' })
    elif not phone_number.isdigit():
        errors_list.append({ 'title': 'Número de contacto del usuario', 'content': 'Debe ingresar un número de contacto válido.' })
    if not password or password == "":
        errors_list.append({ 'title': 'Contraseña del usuario', 'content': 'Debe ingresar una contraseña.' })
    return errors_list

def register_html(request):
    return_content = {}
    return_errors = []
    if request.POST:
        print("2")
        identification = request.POST.get("identification", "")
        first_name = request.POST.get('first_name', '')
        last_name = request.POST.get('last_name', '')
        email = request.POST.get('email', '')
        password = request.POST.get('password', '')
        phone_number = request.POST.get('phone_number', '')
        datetime_tz = datetime.now(tz=pytz.timezone('America/Bogota'))

        return_errors = validate_register(return_errors, identification, first_name, last_name, email, password, phone_number)
        return_content['errors'] = return_errors
        print("return_content:", return_content)
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
            )
            user.set_password(password)
            user.save()
            return redirect('/accounts/login')

    return render(request, 'registration/signup.html', return_content)

@login_required
def manage_profile(request):
    return_content = {}
    return_errors = []
    if request.POST:
        print("2")
        identification = request.POST.get("identification", "")
        first_name = request.POST.get('first_name', '')
        last_name = request.POST.get('last_name', '')
        email = request.POST.get('email', '')
        password = request.POST.get('password', '')
        phone_number = request.POST.get('phone_number', '')
        datetime_tz = datetime.now(tz=pytz.timezone('America/Bogota'))

        return_errors = validate_register(return_errors, identification, first_name, last_name, email, password, phone_number)
        return_content['errors'] = return_errors
        print("return_content:", return_content)
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
            )
            user.set_password(password)
            user.save()
            return redirect('/accounts/login')

    return render(request, 'registration/signup.html', return_content)