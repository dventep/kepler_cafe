# Generated by Django 4.0.3 on 2023-08-16 19:07

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('Inventory', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Custom_Order',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('description', models.CharField(blank=True, default=None, max_length=200, null=True, verbose_name='Descripción')),
                ('creation_date', models.DateTimeField(auto_now_add=True, verbose_name='Fecha de creación')),
                ('status', models.CharField(choices=[('waiting', 'En espera'), ('success', 'Realizada')], default='', max_length=50, verbose_name='Estado de orden')),
            ],
            options={
                'verbose_name': 'Compra principal',
                'verbose_name_plural': 'Compras principales',
                'ordering': ['creation_date', 'product_shopping_car', 'purchase_detail'],
            },
        ),
        migrations.CreateModel(
            name='Main_Purchase',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('money_total_value', models.FloatField(blank=True, default=None, null=True, verbose_name='Valor total monetario')),
                ('point_total_value', models.IntegerField(blank=True, default=None, null=True, verbose_name='Valor total en puntos')),
                ('creation_date', models.DateTimeField(auto_now_add=True, verbose_name='Fecha de creación')),
                ('delivery_date', models.DateTimeField(verbose_name='Fecha de entrega')),
            ],
            options={
                'verbose_name': 'Compra principal',
                'verbose_name_plural': 'Compras principales',
                'ordering': ['creation_date', 'delivery_date', 'money_total_value', 'point_total_value'],
            },
        ),
        migrations.CreateModel(
            name='Point_Transaction',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('quantity_point', models.IntegerField(default=0, verbose_name='Cantidad de puntos')),
                ('action', models.CharField(choices=[('out', 'Compra'), ('in', 'Recepción')], default='', max_length=50, verbose_name='Acción de transacción')),
                ('transaction_date', models.DateTimeField(verbose_name='Fecha de transacción')),
            ],
            options={
                'verbose_name': 'Transacción de puntos',
                'verbose_name_plural': 'Transacciones de puntos',
                'ordering': ['transaction_date', 'action', 'purchase_detail'],
            },
        ),
        migrations.CreateModel(
            name='Purchase_Detail',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('money_unit_value', models.FloatField(blank=True, default=None, null=True, verbose_name='Valor unitario monetario')),
                ('point_unit_value', models.IntegerField(blank=True, default=None, null=True, verbose_name='Valor unitario en puntos')),
                ('quantity', models.IntegerField(default=0, verbose_name='Cantidad')),
                ('main_purchase', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='main_purchase_purchase_detail', to='Movement.main_purchase', verbose_name='Compra principal')),
                ('product', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='product_purchase_detail', to='Inventory.product', verbose_name='Producto')),
            ],
            options={
                'verbose_name': 'Detalle de compra',
                'verbose_name_plural': 'Detalles de compra',
                'ordering': ['main_purchase', 'product', 'money_unit_value', 'point_unit_value'],
            },
        ),
        migrations.CreateModel(
            name='Product_Shopping_Car',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('quantity', models.IntegerField(default=0, verbose_name='Cantidad')),
                ('creation_date', models.DateTimeField(auto_now_add=True, verbose_name='creation date')),
                ('product', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='product_product_shopping_car', to='Inventory.product', verbose_name='Producto')),
            ],
            options={
                'verbose_name': 'Carrito de compra',
                'verbose_name_plural': 'Carritos de compras',
                'ordering': ['user', 'product'],
            },
        ),
    ]
