from django.contrib import admin
from import_export.admin import ImportExportModelAdmin
from .models import Product, Category

@admin.register(Product)
class ProductAdmin(ImportExportModelAdmin):
    @admin.display(description="Peso", ordering="weight")
    def formated_weight(self, obj):
        if obj.weight:
            return obj.weight
        else:
            return "-"
    @admin.display(description="Categoría", ordering="category__name")
    def category_name(self, obj):
        return obj.category.name

    list_display = (
		"pk",
		"name",
		"money_unit_price",
		"point_unit_price",
		"quantity",
		"formated_weight",
		"category_name",
		"status",
		)
    search_fields = (
		'pk',
		'name',
        "category__name",
        )
    list_filter = (
		'category__name',
    	)

@admin.register(Category)
class CategoryAdmin(ImportExportModelAdmin):
    list_display = (
		"pk",
		"name",
		)
    search_fields = (
		'pk',
		'name',
    	)
