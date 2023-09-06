from import_export.admin import ImportExportModelAdmin

from django.contrib import admin
from django_admin_reset.admin import PasswordResetUserAdmin

from .models import UserProfile, Charge

if admin.site.is_registered(UserProfile):
    admin.site.unregister(UserProfile)
@admin.register(UserProfile)
class UserProfileAdmin(ImportExportModelAdmin, PasswordResetUserAdmin):
    @admin.display(description="Usuario", ordering="user__identification")
    def charge_name(self, obj):
        if obj.charge:
            return f"{obj.charge.name}"
        else:
            return "-"
    @admin.display(description="Fecha de creación", ordering="creation_date")
    def formated_creation_date(self, obj):
        return obj.creation_date.strftime("%d/%m/%Y %H:%M:%S")
    @admin.display(description="Fecha de inactivo", ordering="inactive_date")
    def formated_inactive_date(self, obj):
      if obj.inactive_date:
        return obj.inactive_date.strftime("%d/%m/%Y %H:%M:%S")
      else:
        return "-"

    list_display = (
      "pk",
      "identification",
      "first_name",
      "last_name",
      "email",
      "point",
      "is_active",
      "is_staff",
      "is_superuser",
      "charge_name",
      "formated_creation_date",
      "formated_inactive_date",
      )
    search_fields = (
		'pk',
        "identification",
        'first_name',
        'last_name',
        'email'
        'charge__name'
        )
    list_filter = (
		'is_active',
		'is_staff',
		'is_superuser',
		'charge__name',
    	)
    
    fieldsets = (
      ('Información personal', {
        'fields': ('identification', "first_name", "last_name", "email", "phone_number", "point", "creation_date", "entrance_date", "birth_date", "inactive_date", "is_active", "is_staff", "is_superuser"),
      }),
      ('Información empleado', {
        'fields': ("salary", "charge")
      })
    )

@admin.register(Charge)
class ChargeAdmin(ImportExportModelAdmin):
    list_display = (
		"pk",
		"name",
		)
    search_fields = (
		'pk',
        'name',
        )
