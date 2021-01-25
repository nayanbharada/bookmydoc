# import self as self
from django.db import models
from django.contrib.auth import get_user_model
from hospital.models import Hospital
from patient.models import Patient
import datetime

User = get_user_model()


# Create your models here.

class DoctorProfile(models.Model):
    SPECIALIZATION = (
        ('dentist', 'Dentist'),
        ('general physician', 'General Physician'),
        ('pediatrician', 'Pediatrician'),
        ('ayurveda', 'Ayurveda'),
        ('orthopedist', 'Orthopedist'),
        ('dental surgeon', 'Dental Surgeon'),
        ('dermatologist', 'Dermatologist'),
        ('general surgeon', 'General Surgeon'),
        ('gynecologist', 'Gynecologist'),

    )

    COUNCIL = (
        ('tamil nadu medical council', 'Tamil Nadu Medical Council'),
        ('medical council of india', 'Medical Council of India'),
        ('andhra pradesh medical council', 'Andhra Pradesh Medical Council'),
        ('assam medical council', 'Assam Medical Council'),
        ('bhopal medical council', 'Bhopal Medical Council'),
        ('bihar medical council', 'Bihar Medical Council'),
        ('bombay medical council', 'Bombay Medical Council'),
        ('chandigarh medical council', 'Chandigarh Medical Council'),
        ('chattisgarh medical council', 'Chattisgarh Medical Council'),
        ('delhi medical council', 'Delhi Medical Council'),
        ('gujarat medical council', 'Gujarat Medical Council'),
        ('goa medical council', 'Goa Medical Council'),
        ('haryana medical council', 'Haryana Medical Council'),
        ('hyderabad medical council', 'Hyderabad Medical Council')
    )
    specialization = models.CharField(max_length=20, choices=SPECIALIZATION)
    registration_no = models.CharField(max_length=20)
    council = models.CharField(max_length=50, choices=COUNCIL)
    experience = models.IntegerField(default=0)
    user = models.OneToOneField(User, on_delete=models.CASCADE,
                                blank=True, related_name='doctor_profile')
    hospital = models.ForeignKey(Hospital, on_delete=models.CASCADE,
                                 blank=True, related_name='doctor_pro')

    def __str__(self):
        return self.user.username


class DoctorDegree(models.Model):
    degree = models.CharField(max_length=250, unique=True)

    def __str__(self):
        return self.degree


class DoctorUniversity(models.Model):
    university_name = models.CharField(max_length=250, unique=True)

    def __str__(self):
        return self.university_name


class Qualification(models.Model):
    # doc_degree = DoctorDegree.objects.all()
    # doc_university = DoctorUniversity.objects.all()
    doctor_profile = models.ForeignKey(DoctorProfile, on_delete=models.CASCADE,
                                       related_name='qualification', blank=True)
    degree = models.CharField(max_length=20)
    university = models.CharField(max_length=80)
    year_completion = models.IntegerField(null=True)

    def __str__(self):
        return self.doctor_profile.user.first_name


class DocTimeSlot(models.Model):
    DAY = (
        ('monday', 'Monday'),
        ('tuesday', 'Tuesday'),
        ('wednesday', 'Wednesday'),
        ('thursday', 'Thursday'),
        ('friday', 'Friday'),
        ('saturday', 'Saturday'),
        ('sunday', 'Sunday')
    )

    doc = models.ForeignKey(DoctorProfile, on_delete=models.CASCADE,
                            related_name='doc_time_slot', blank=True)
    hospital = models.ForeignKey(Hospital, on_delete=models.CASCADE,
                                 related_name='hospital_time_slot', blank=True)
    days = models.CharField(max_length=10, choices=DAY)
    from_time = models.TimeField()
    to_time = models.TimeField()

    def __str__(self):
        return self.doc.user.username


class Appointment(models.Model):
    Booked = 'Booked'
    Ongoing = 'Ongoing'
    Completed = 'Completed'
    Cancel = 'Cancel'

    APPOINTMENT_STATUS = (
        (Booked, "Booked"),
        (Ongoing, "Ongoing"),
        (Completed, "Completed"),
        (Cancel, "Cancel"),
    )
    hospital = models.ForeignKey(Hospital, on_delete=models.CASCADE, related_name='hospital_id', null=True)
    patient = models.ForeignKey(Patient, on_delete=models.CASCADE, related_name='patient_id', null=True)
    doctor = models.ForeignKey(DoctorProfile, on_delete=models.CASCADE, related_name='doc_id', blank=True)
    date = models.DateField()
    time_slot = models.ForeignKey(DocTimeSlot, on_delete=models.CASCADE, related_name='time_slot', blank=True)
    created_by = models.ForeignKey(get_user_model(), on_delete=models.CASCADE, related_name='app_create', blank=True)
    canceled_by = models.ForeignKey(get_user_model(), on_delete=models.CASCADE, related_name='app_cancel', null=True)
    status = models.CharField(max_length=10, choices=APPOINTMENT_STATUS, null=True, blank=True)


class CheckupTiming(models.Model):
    appointment = models.OneToOneField(Appointment, on_delete=models.CASCADE, related_name='appointment_id',
                                       null=True, blank=True)
    doc = models.ForeignKey(DoctorProfile, on_delete=models.CASCADE, related_name='doc_pro_id',
                            null=True, blank=True)
    date = models.DateField()
    check_in = models.TimeField(blank=True, null=True)
    check_out = models.TimeField(blank=True, null=True)

