from django.shortcuts import render

# Create your views here.
def passa(request):
    shopping_car_quantity = 0
    if request.user.is_authenticated:
        shopping_car_quantity = Shopping_Car.objects.filter(user_id = request.user.identification).count()