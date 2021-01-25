from django.urls import path
from . import views

app_name = 'doctor'
urlpatterns = [
    path('index', views.index, name="index"),
    path('dashboard', views.DoctorDashboardView.as_view(), name="dashboard"),
    path('doc_profile/<int:pk>', views.DoctorProfileView.as_view(), name="doc_profile"),
    path('doc_qualification', views.QualificationView.as_view(), name="doc_qualification"),
    path('delete_doc_qualification/<int:pk>', views.DeleteDocQualification.as_view(), name="delete_doc_qualification"),
    path('edit_doc_qualification/<int:pk>', views.EditDocQualification.as_view(), name="edit_doc_qualification"),
    path('doc_time_slot', views.DocTimeSlotView.as_view(), name="doc_time_slot"),
    path('edit_doc_time_slot/<int:pk>', views.EditDocTimeSlot.as_view(), name="edit_doc_time_slot"),
    path('delete_doc_time_slot/<int:pk>', views.DeleteDocTimeSlot.as_view(), name="delete_doc_time_slot"),
    path('today_appointments', views.TodayAppointments.as_view(), name="today_appointments"),
    path('cancel_today_appointments/<int:pk>', views.CancelTodayAppointments.as_view(), name="cancel_today_appointments"),
    path('change_appointment_status', views.ChangeAppointmentStatus.as_view(), name="change_appointment_status"),
    path('check_status', views.CheckStatus.as_view(), name="check_status"),
    path('all_appointments', views.AllAppointments.as_view(), name="all_appointments"),
    path('cancel_appointments/<int:pk>', views.CancelAppointments.as_view(), name="cancel_appointments"),
    path('patient_medical_history/<int:pk>', views.PatientMedicalHistory.as_view(), name="patient_medical_history"),
    path('all_hospital', views.AllHospitalView.as_view(), name="all_hospital"),
    path('doctor_list_view/<int:pk>', views.DoctorListView.as_view(), name="doctor_list_view"),
    path('other_appointments', views.OtherAppointmentView.as_view(), name="other_appointments"),
    path('status_filter', views.StatusFilter.as_view(), name="status_filter"),
    path('show_checkup_timing', views.ShowCheckupTiming.as_view(), name="show_checkup_timing")



]
