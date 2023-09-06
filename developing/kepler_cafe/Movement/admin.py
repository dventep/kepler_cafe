from django.contrib import admin
from import_export.admin import ImportExportModelAdmin
from .models import Shopping_Car, Main_Purchase, Purchase_Detail, Point_Transaction

@admin.register(Shopping_Car)
class Shopping_CarAdmin(ImportExportModelAdmin):
    @admin.display(description="Usuario", ordering="user__identification")
    def fullname_user(self, obj):
        return f"{obj.user.first_name} {obj.user.last_name}"
    @admin.display(description="Producto", ordering="product__name")
    def product_name(self, obj):
        return f"{obj.product.name}"
    @admin.display(description="Fecha de creación", ordering="creation_date")
    def formated_creation_date(self, obj):
        return obj.creation_date.strftime("%d/%m/%Y %H:%M:%S")

    list_display = (
		"pk",
		"fullname_user",
		"product_name",
		"quantity",
		"formated_creation_date",
		)

    search_fields = (
		'pk',
		'product__name',
        "user__identification",
        'user__first_name',
        'user__last_name'
        )

    list_filter = (
		'product__name',
    	)

@admin.register(Main_Purchase)
class Main_PurchaseAdmin(ImportExportModelAdmin):
    @admin.display(description="Usuario", ordering="user__identification")
    def fullname_user(self, obj):
        return f"{obj.user.first_name} {obj.user.last_name}"
    @admin.display(description="Fecha de creación", ordering="creation_date")
    def formated_creation_date(self, obj):
        return obj.creation_date.strftime("%d/%m/%Y %H:%M:%S")
    @admin.display(description="Fecha de entrega", ordering="delivery_date")
    def formated_delivery_date(self, obj):
        if obj.delivery_date:
            return obj.delivery_date.strftime("%d/%m/%Y %H:%M:%S")
        return "-"

    list_display = (
		"pk",
		"fullname_user",
		"money_total_value",
		"point_total_value",
		"formated_creation_date",
		"formated_delivery_date",
		)

    search_fields = (
		'pk',
        "user__identification",
        'user__first_name',
        'user__last_name',
        )
    date_hierarchy = 'creation_date'
    
@admin.register(Purchase_Detail)
class Purchase_DetailAdmin(ImportExportModelAdmin):
    @admin.display(description="Usuario", ordering="user__identification")
    def fullname_user(self, obj):
        return f"{obj.main_purchase.user.first_name} {obj.main_purchase.user.last_name}"
    @admin.display(description="Producto", ordering="product__name")
    def product_name(self, obj):
        return f"{obj.product.name}"
    @admin.display(description="Fecha de creación", ordering="main_purchase__creation_date")
    def formated_creation_date(self, obj):
        return obj.main_purchase.creation_date.strftime("%d/%m/%Y %H:%M:%S")

    list_display = (
		"pk",
		"fullname_user",
		"product_name",
        "status",
		"money_unit_value",
		"point_unit_value",
		"quantity",
		"formated_creation_date",
		)
    search_fields = (
		'pk',
		'product__name',
        "main_purchase__user__identification",
        'main_purchase__user__first_name',
        'main_purchase__user__last_name'
        )
    list_filter = (
		'product__name',
    	)

@admin.register(Point_Transaction)
class Point_TransactionAdmin(ImportExportModelAdmin):
    @admin.display(description="Usuario", ordering="purchase_detail__user__identification")
    def fullname_user(self, obj):
        return f"{obj.purchase_detail.main_purchase.user.first_name} {obj.purchase_detail.main_purchase.user.last_name}"
    @admin.display(description="Producto", ordering="purchase_detail__product__name")
    def product_name(self, obj):
        return f"{obj.purchase_detail.product.name}"
    @admin.display(description="Fecha de transacción", ordering="transaction_date")
    def formated_transaction_date(self, obj):
        return obj.transaction_date.strftime("%d/%m/%Y %H:%M:%S")

    list_display = (
		"pk",
		"fullname_user",
		"product_name",
		"quantity_point",
		"action",
		"formated_transaction_date",
		)

    search_fields = (
		'pk',
		'purchase_detail__product__name',
        "purchase_detail__main_purchase__user__identification",
        'purchase_detail__main_purchase__user__first_name',
        'purchase_detail__main_purchase__user__last_name'
        )
    list_filter = (
		'action',
		'purchase_detail__product__name',
    	)