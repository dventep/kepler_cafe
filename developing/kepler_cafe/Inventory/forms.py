from django.forms import ModelForm
from .models import Product

class Add_inventory(ModelForm):
    class Meta:
        model = Product
        fields = ['name', 'cost_per_item', 'quantity_in_stock', 'quantity_sold']

class UpdateInventoryForm(ModelForm):
    class Meta:
        model = Product
        fields = ['name', 'cost_per_item', 'quantity_in_stock', 'quantity_sold']       