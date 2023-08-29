from django.contrib import admin
from django.urls import path
from django.urls import include
# from .views import products_list, Product_Description

# urlpatterns = [
#     path('shop/', products_list),
from .views import inventory_list, Product_Description
# per_product_view
# , add_product, delete_product

urlpatterns = [
    path('shop/', inventory_list, name="shop"),
    path('shop/product/', Product_Description, name="product_description"),
    # path('product/<int:pk>', per_product_view, name="Product Detail"),
    # path('add_inventory/', add_product, name="add_inventory"),
    # path('delete/<int:pk>', delete_product, name="delete_product")
]