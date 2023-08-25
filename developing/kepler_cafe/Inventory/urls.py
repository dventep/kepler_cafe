from django.contrib import admin
from django.urls import path
from django.urls import include
# from .views import products_list, Product_Description

# urlpatterns = [
#     path('shop/', products_list),
#     path('product/', Product_Description),
from .views import inventory_list, per_product_view
# , add_product, delete_product

urlpatterns = [
    path('inventory/', inventory_list, name="shop"),
    # path('product/<int:pk>', per_product_view, name="Product Detail"),
    # path('add_inventory/', add_product, name="add_inventory"),
    # path('delete/<int:pk>', delete_product, name="delete_product")
]