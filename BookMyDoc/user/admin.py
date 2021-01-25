from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from .models import User, Contact, Carousel

# Register your models here.

UserAdmin.fieldsets += ('Custom fields set', {'fields': ('is_type', 'mobile_number',
                                                         'gender', 'profile_image')}),
admin.site.register(User, UserAdmin)
admin.site.register(Contact)
admin.site.register(Carousel)