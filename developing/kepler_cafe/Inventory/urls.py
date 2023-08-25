from django.contrib import admin
from django.urls import path
from django.urls import include
from .views import inventory_list, per_product_view, add_product, delete_product

urlpatterns = [
    path('inventory/', inventory_list, name="Kepler's inventory"),
    path('product/<int:pk>', per_product_view, name="Product Detail"),
    path('add_inventory/', add_product, name="add_inventory"),
    path('delete/<int:pk>', delete_product, name="delete_product")
]