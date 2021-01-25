# Generated by Django 2.2 on 2020-01-31 06:38

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Hospital',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=50)),
                ('is_type', models.CharField(choices=[('hospital', 'Hospital'), ('clinic', 'Clinic')], max_length=8)),
                ('website', models.URLField()),
                ('address', models.CharField(blank=True, max_length=500)),
                ('no_of_opd', models.IntegerField(default=0)),
            ],
        ),
        migrations.CreateModel(
            name='HospitalRequest',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=50)),
                ('email', models.EmailField(max_length=254)),
                ('mobile', models.CharField(max_length=10)),
                ('type', models.CharField(choices=[('hospital', 'Hospital'), ('clinic', 'Clinic')], max_length=8)),
                ('username', models.CharField(max_length=20)),
                ('website', models.URLField()),
            ],
        ),
    ]
