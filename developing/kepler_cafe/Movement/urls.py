from django.contrib import admin
from django.urls import path
from django.urls import include
from .views import add_product_shopping_car, remove_product_shopping_car, look_product_shopping_car

urlpatterns = [
    path('shopping_car/', look_product_shopping_car, name="shopping_car"),
    path('shopping_car/add/', add_product_shopping_car, name="shopping_car_add"),
    path('shopping_car/remove/', remove_product_shopping_car, name="shopping_car_remove"),
]