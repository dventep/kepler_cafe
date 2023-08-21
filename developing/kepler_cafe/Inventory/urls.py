from django.contrib import admin
from django.urls import path
from django.urls import include
from .views import products_list, Product_Description

urlpatterns = [
    path('shop/', products_list),
    path('product/', Product_Description),
]