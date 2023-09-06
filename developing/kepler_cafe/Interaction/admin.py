from django.contrib import admin
from import_export.admin import ImportExportModelAdmin
from .models import Question, Question_Answer

@admin.register(Question)
class QuestionAdmin(ImportExportModelAdmin):
    @admin.display(description="Fecha de creación", ordering="creation_date")
    def formated_creation_date(self, obj):
        return obj.creation_date.strftime("%d/%m/%Y %H:%M:%S")
    list_display = (
		"pk",
		"name",
		"formated_creation_date",
		)
    search_fields = (
		'pk',
		'name',
        )
    date_hierarchy = 'creation_date'
    
@admin.register(Question_Answer)
class Question_AnswerAdmin(ImportExportModelAdmin):
    @admin.display(description="Usuario", ordering="user__identification")
    def question_name(self, obj):
        return f"{obj.question.name}"
    @admin.display(description="Producto", ordering="product__name")
    def product_name(self, obj):
        if obj.product:
            return f"{obj.product.name}"
        else:
            return "-"
    @admin.display(description="Fecha de creación", ordering="creation_date")
    def formated_creation_date(self, obj):
        return obj.creation_date.strftime("%d/%m/%Y %H:%M:%S")

    list_display = (
		"pk",
		"question_name",
		"product_name",
		"score",
		"formated_creation_date",
		)
    search_fields = (
		'pk',
		'product__name',
        'question__name',
        )
    list_filter = (
		'question__name',
    	)
