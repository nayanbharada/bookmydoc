from django.urls import path
from . import views
from .views import UserProfile, PatientMedicalHistory
app_name = 'patient'
urlpatterns = [
    path('index', views.index, name="index"),
    path('wrong', views.write, name="wrong"),
    path('user_profile/<int:pk>', UserProfile.as_view(), name="user_profile"),
    path('patient_medical_history', PatientMedicalHistory.as_view(), name="patient_medical_history"),
    path('all_hospital', views.DisplayHospital.as_view(), name="all_hospital"),
    path('hospital_detail/<int:pk>/', views.HospitalDetailView.as_view(), name="hospital_detail"),
    path('booking/<int:pk>', views.BookingView.as_view(), name="booking"),
    path('time_slot', views.AppointmentBooking.as_view(), name="time_slot"),
    path('my_appointments', views.MyAppointmentsView.as_view(), name="my_appointments"),
    path('cancel_appointments/<int:pk>', views.CancelAppointments.as_view(), name="cancel_appointments"),
]
