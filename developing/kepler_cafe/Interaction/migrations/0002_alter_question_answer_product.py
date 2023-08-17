# Generated by Django 4.0.3 on 2023-08-17 03:15

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('Inventory', '0002_product_status'),
        ('Interaction', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='question_answer',
            name='product',
            field=models.ForeignKey(blank=True, default=None, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='product_question_answer', to='Inventory.product', verbose_name='Producto'),
        ),
    ]