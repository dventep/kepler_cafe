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

def home(request):
    return render(request, "user/index.html")

def validate_register(identification_validate, errors_list, identification, first_name, last_name, email, password, phone_number, updating = False):
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
        
    return errors_list

def register_html(request):
    """
        Description:
            This function has the objective to get the template to register and create the client record. 
    """
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

        return_errors = validate_register(request=request, errors_list=return_errors, identification=identification, first_name=first_name, last_name=last_name, email=email, password=password, phone_number=phone_number)
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
        identification = request.POST.get("identification", "")
        first_name = request.POST.get('first_name', '')
        last_name = request.POST.get('last_name', '')
        email = request.POST.get('email', '')
        password = request.POST.get('password', '')
        phone_number = request.POST.get('phone_number', '')

        return_errors = validate_register(request=request, errors_list=return_errors, identification=identification, first_name=first_name, last_name=last_name, email=email, password=password, phone_number=phone_number, updating=True)
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
    if request.user.is_staff or request.user.is_superuser:
        return_content['charge_list'] = list(Charge.objects.all().values('pk', 'name').order_by('name', 'pk'))

    return render(request, 'user/user.html', return_content)

@login_required
def get_profiles(request):
    """
        Description:
            This function has the objective to return all users information except the admin user. 
    """
    return_content = {'errors': [], 'message': {}}
    return_errors = []
    if request.user.is_superuser:
        users_list = list(UserProfile.objects.all().exclude(pk = request.user.pk).values(
            'identification',
            'first_name',
            'last_name',
            'email',
            'phone_number',
            'salary',
            'entrance_date',
            'is_staff',
            'is_superuser',
            charge_name = F('charge__name'),
        ))
        return_content['errors'] = return_errors
        return_content['users_list'] = users_list

        return render(request, 'user/profiles.html', return_content)

    return redirect("/")
        
@login_required
def get_profile(request):
    """
        Description:
            This function has the objective to return user record to be updated.
    """
    return_content = {'errors': [], 'message': {}}
    if request.user.is_superuser and request.POST:
        user_info = {}
        return_errors = []
        
        identification = request.POST.get('identification', '')
        if identification and identification != '':
            if UserProfile.objects.filter(identification = identification).exists():
                user_info = list(UserProfile.objects.filter(identification = identification).values(
                    'identification',
                    'first_name',
                    'last_name',
                    'email',
                    'phone_number',
                    'salary',
                    'is_staff',
                    'is_superuser',
                    'charge_id'
                ).annotate(
                    entrance_date=Func(
                        F('entrance_date'),
                        Value('DD-MM-YYYY HH:MM:SS'),
                        function='to_char',
                        output_field=CharField()
                    )
                    )
                )[0]
            else:
                return_errors.append({ 'title': 'Identificación del usuario', 'content': f"No existe algún usuario con la identificación '{identification}'." })
        else:
            return_errors.append({ 'title': 'Identificación del usuario', 'content': 'No se recibió la identificación del usuario para obtener la información.' })

        return_content['charge_list'] = list(Charge.objects.all().values('pk', 'name').order_by('name', 'pk'))
        return_content['errors'] = return_errors
        return_content['user_info'] = user_info

        return render(request, 'user/profile.html', return_content)
        # return JsonResponse(return_content)

    return redirect("/")
        
@login_required
def save_profile(request):
    """
        Description:
            This function has the objective to update the user with his information. 
    """
    return_content = {'errors': [], 'message': {}}
    try:
        if request.user.is_superuser and request.POST:
            user_info = {}
            return_errors = []
            
            identification = request.POST.get("identification", "")
            first_name = request.POST.get('first_name', '')
            last_name = request.POST.get('last_name', '')
            email = request.POST.get('email', '')
            phone_number = request.POST.get('phone_number', '')
            password = " "
            salary = request.POST.get('salary', '')
            is_staff = request.POST.get('is_staff', '')
            is_superuser = request.POST.get('is_superuser', '')
            charge_id = request.POST.get('charge_id', '')

            return_errors = validate_register(identification_validate=identification, errors_list=return_errors, identification=identification, first_name=first_name, last_name=last_name, email=email, password=password, phone_number=phone_number, updating=True)

            if charge_id != '' and not Charge.objects.filter(pk = charge_id).exists():
                return_errors.append({ 'title': 'Cargo del usuario', 'content': f"No existe el cargo seleccionado '{charge_id}'." })
            if charge_id == "":
                charge_id = None
            if salary != '' and not salary.isdigit():
                return_errors.append({ 'title': 'Salario del usuario', 'content': f"El salario del usuario no es válido: '{salary}'." })
            if salary == "":
                salary = None
            
            if len(return_errors) == 0:
                if UserProfile.objects.filter(identification = identification).exists():
                    UserProfile.objects.filter(identification = identification).update(
                        first_name = first_name,
                        last_name = last_name,
                        email = email,
                        phone_number = phone_number,
                        salary = salary,
                        is_staff = is_staff,
                        is_superuser = is_superuser,
                        charge_id = charge_id
                    )
                else:
                    return_errors.append({ 'title': 'Identificación del usuario', 'content': f"No existe algún usuario con la identificación '{identification}'." })
                print("6")

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
    except:
        print(traceback.format_exc())

    return JsonResponse(return_content)