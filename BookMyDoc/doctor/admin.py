from django.contrib import admin
from .models import DoctorProfile, Qualification, DocTimeSlot, Appointment,\
    CheckupTiming, DoctorDegree, DoctorUniversity

# Register your models here.

admin.site.register(DoctorProfile)
admin.site.register(Qualification)
admin.site.register(DocTimeSlot)
admin.site.register(Appointment)
admin.site.register(CheckupTiming)
admin.site.register(DoctorDegree)
admin.site.register(DoctorUniversity)
