from django.urls import path
from . import views
from .views import HospitalProfile

app_name = "hospital"
urlpatterns = [
    path('index', views.index, name="index"),
    path('hospital_dashboard', views.HospitalDashboard.as_view(), name="hospital_dashboard"),
    path('hospital_request', views.HospitalClinicRequest.as_view(), name="hospital_request"),
    path('hospital_profile/<int:pk>', HospitalProfile.as_view(), name="hospital_profile"),
    path('add_doctor', views.AddDoctor.as_view(), name="add_doctor"),
    path('doc_list', views.AllDoctorListView.as_view(), name="doc_list"),
    path('appointment_slot/<int:pk>', views.AppointmentTimeSlotView.as_view(), name="appointment_slot"),
    path('appointment_book', views.AppointmentBookView.as_view(), name="appointment_book"),
    path('upload_hospital_images', views.UploadHospitalImages.as_view(), name="upload_hospital_images"),
    path('all_hospital_images', views.AllHospitalImages.as_view(), name="all_hospital_images"),
    path('hospital_delete_image/<int:pk>', views.HospitalDeleteImage.as_view(), name="hospital_delete_image"),
    path('all_doctor_list', views.AllDocList.as_view(), name="all_doctor_list"),
    path('delete_doc/<int:pk>', views.DeleteDoc.as_view() , name="delete_doc")

]
