# Generated by Django 2.2 on 2020-02-04 12:04

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('doctor', '0010_auto_20200204_1717'),
    ]

    operations = [
        migrations.CreateModel(
            name='DoctorUniversity',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('university_name', models.CharField(max_length=250, unique=True)),
            ],
        ),
        migrations.AlterField(
            model_name='doctordegree',
            name='degree',
            field=models.CharField(max_length=250, unique=True),
        ),
    ]
