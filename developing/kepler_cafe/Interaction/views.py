from datetime import date, timedelta, datetime, time
import pytz, traceback

from django.db.models import F, Func, Value, CharField, BooleanField
from django.contrib.auth.hashers import make_password
from django.shortcuts import render, redirect
from django.db.models import F
from django.http import HttpResponse, JsonResponse
from django.utils.timezone import make_aware, utc
from django.contrib.auth.decorators import login_required
from django.template.loader import get_template
from django.core.mail import EmailMultiAlternatives
from django.conf import settings

from Movement.models import Shopping_Car, Main_Purchase, Purchase_Detail, Point_Transaction
from Inventory.models import Product
from User.models import UserProfile
from .models import Question, Question_Answer

@login_required
def Survey_Me(request):
    """
        Description:
            This function has the objective to get all user surveys selected. 
    """
    return_content = {'errors': [], 'message': {}, 'surveys_to_do_list': [], 'surveys_done_list': []}
    return_errors = []
    shopping_car_quantity = 0
    
    surveys_to_do_list = []
    question_exclude_list = []
    products_question_exclude_list = []
    question_exclude_record = list(zip(*Question_Answer.objects.filter(user_id = request.user.pk).values_list('question_id', 'product_id')))
    if len(question_exclude_record) > 0:
        question_exclude_list = question_exclude_record[0]
        products_question_exclude_list = question_exclude_record[1]
    # purchase_detail_list = Purchase_Detail.objects.filter(main_purchase__user_id = request.user.pk)
    surveys_to_do_list = list(Question.objects.filter(with_product = False).exclude(pk__in = question_exclude_list).values(
        "name",
        "with_product",
        survey_id = F('pk'),
        question_description = F('description'),
        product_id = Value(None, output_field=BooleanField()),
        product_name = Value(None, output_field=BooleanField())
    ))
    products_survey_list = []
    products_exclude_list = list(zip(*Purchase_Detail.objects.filter(main_purchase__user_id = request.user.pk).exclude(product_id__in = products_question_exclude_list).values_list('product_id')))
    if len(products_exclude_list) > 0:
        question_survey_list = Question.objects.filter(with_product = True).values(
            "name",
            "with_product",
            survey_id = F('pk'),
            question_description = F('description')
        )
        for question in question_survey_list:
            for product in products_exclude_list[0]:
                if not Question_Answer.objects.filter(user_id = request.user.pk, product_id = product, question_id = question['survey_id']).exists():
                    product_name = Product.objects.get(pk = product).name
                    products_survey_list.append({
                        "survey_id": question['survey_id'],
                        "name": question['name'],
                        "question_description": question['question_description'],
                        "with_product": question['with_product'],
                        "product_id": product,
                        "product_name": product_name
                    })
    surveys_to_do_list += products_survey_list
    surveys_done_list = list(Question_Answer.objects.filter(user_id = request.user.pk).values(
        'score',
        "product_id",
        name = F('question__name'),
        question_description = F('question__description'),
        with_product = F('question__with_product'),
        product_name = F('product__name'),
        answer_description = F('description'),
        creation_date_format = Func(
            F('creation_date'),
            Value('DD/MM/YYYY'),
            function = 'to_char',
            output_field=CharField()
        )
    ))
    
    return_content['surveys_to_do_list'] = surveys_to_do_list
    return_content['surveys_done_list'] = surveys_done_list
    return_content['errors'] = return_errors
    shopping_car_quantity = Shopping_Car.objects.filter(user_id = request.user.identification).count()
    
    return_content['shopping_car_quantity'] = shopping_car_quantity
    return render(request, 'interaction/surveys.html', return_content)
    # return JsonResponse(return_content)
    
@login_required
def Survey_Do(request):
    """
        Description:
            This function has the objective to get survey selected. 
    """
    return_content = {'errors': [], 'message': {}, 
                      "survey_id": None,
                      "name": "",
                      "question_description": "",
                      "with_product": "",
                      "product_id": None,
                      "product_name": "",
                      "description": "",
                      "score": 0,
                      }
    return_errors = []

    shopping_car_quantity = Shopping_Car.objects.filter(user_id = request.user.identification).count()
    return_content['shopping_car_quantity'] = shopping_car_quantity
    
    if request.POST:
        survey_id = request.POST.get('survey', None)
        product_id = request.POST.get('product', None)
        description = request.POST.get('description', None)
        score = request.POST.get('score', None)
        
        if survey_id and product_id and description and score:

            Question_Answer.objects.create(
                score = score,
                description = description,
                question_id = survey_id,
                product_id = product_id,
                user_id = request.user.pk,
                creation_date = datetime.now(tz=pytz.timezone('America/Bogota'))
            )

            return redirect("/surveys/me/")
        else:
            return_content['errors'].append({ 'title': 'Error en recepción de datos', 'content': 'Survey_id, product_id, description o score faltó por enviar' })
        return render(request, 'interaction/survey.html', return_content)
        # return JsonResponse(return_content)

    else:
        survey_id = request.GET.get('survey', None)
        product_id = request.GET.get('product', None)
        
        if survey_id and Question.objects.filter(pk = survey_id).exists():
            if Question.objects.filter(pk = survey_id, with_product = True).exists():
                if product_id and Product.objects.filter(pk = product_id).exists():
                    question_info = Question.objects.filter(pk = survey_id).values("description", "with_product", 'name').get()
                    product_info = Product.objects.filter(pk = product_id).values("name").get()
                    
                    return_content["name"] = question_info['name']
                    return_content["question_description"] = question_info['description']
                    return_content["with_product"] = question_info['with_product']
                    return_content["product_name"] = product_info['name']
                else:
                    return redirect("/")
            else:
                question_info = Question.objects.filter(pk = survey_id).values("description", "with_product", "name").get()
                # product_info = Product.objects.filter(pk = product_id).values("name").get()
                
                return_content["name"] = question_info['name']
                return_content["question_description"] = question_info['description']
                return_content["with_product"] = question_info['name']
                return_content["product_name"] = None
        else:
            return redirect("/")
        
        return_content["survey_id"] = survey_id
        return_content["product_id"] = product_id
        return_content["description"] = ""
        return_content["score"] = 0
        return render(request, 'interaction/survey.html', return_content)
        # return JsonResponse(return_content)
    
    # return JsonResponse(return_content)
    return redirect("/surveys/me")