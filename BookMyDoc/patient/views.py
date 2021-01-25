import datetime
from django.contrib import messages
from django.contrib.auth.mixins import LoginRequiredMixin
from django.core.exceptions import ObjectDoesNotExist
from django.core.mail import EmailMessage
from django.shortcuts import render, redirect
from django.http import HttpResponse
from django.template.loader import render_to_string
from django.views.generic import View, CreateView, UpdateView, FormView, ListView, DetailView
from BookMyDoc.settings import EMAIL_HOST_USER
from .forms import PatientProfileForm, UserProfileForm
from django.contrib.auth import get_user_model
from .models import Patient
from doctor.models import Appointment
from doctor.models import DoctorProfile, Qualification, DocTimeSlot
from hospital.models import Hospital
from datetime import datetime, timezone
from django.http import JsonResponse


# Create your views here.

# @login_required
def index(request):
    return render(request, 'patient/patient_index.html', {})


def write(request):
    return HttpResponse("wrongg")


class UserProfile(LoginRequiredMixin, UpdateView):
    model = get_user_model()
    form_class = UserProfileForm
    template_name = 'patient/user_profile.html'
    success_url = '/patient/index'


class PatientMedicalHistory(LoginRequiredMixin, View):
    template_name = 'patient/patient_medical_history.html'
    form_class = PatientProfileForm

    def get(self, request, *args, **kwargs):
        user = request.user
        try:
            patient_data = Patient.objects.get(user_id=user.id)
        except ObjectDoesNotExist:
            patient_data = None

        if patient_data is None:
            form = self.form_class()
            return render(request, self.template_name, {'form': form})
        else:
            form = self.form_class(instance=patient_data)
            return render(request, self.template_name, {'form': form})

    def post(self, request, *args, **kwargs):
        try:
            patient_data = Patient.objects.get(user_id=request.user.id)
            form = self.form_class(request.POST, instance=patient_data)
        except ObjectDoesNotExist:
            patient_data = None
            form = self.form_class(request.POST)

        if form.is_valid():
            if patient_data is None:
                instance = form.save(commit=False)
                instance.user = request.user
                instance.save()
                messages.success(request, 'Patient detail will updated.')
                return redirect('patient:patient_medical_history')
            else:
                messages.success(request, 'Patient detail will updated.')
                form.save()
                return redirect('patient:patient_medical_history')
        else:
            return render(request, self.template_name, {'form': form})


class DisplayHospital(ListView):
    template_name = 'patient/all_hospital.html'
    model = Hospital
    context_object_name = 'all_hospital'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        return context


class HospitalDetailView(DetailView):
    template_name = 'patient/hospital_detail.html'

    def get(self, request, *args, **kwargs):
        hospital_id = self.kwargs.get('pk')
        hospital_obj = Hospital.objects.get(id=hospital_id)
        doc_lists = DoctorProfile.objects.filter(hospital_id=hospital_id)
        return render(request, self.template_name, {'doc_lists': doc_lists, 'hospital_obj': hospital_obj})


class BookingView(LoginRequiredMixin, View):
    template_name = "patient/booking_detail.html"

    def get(self, request, *args, **kwargs):
        doc_id = self.kwargs.get('pk')
        data = DoctorProfile.objects.get(id=doc_id)
        return render(self.request, self.template_name, {'data': data})

    def post(self, request, *args, **kwargs):
        date = request.POST.get('the_post')
        doc_pro_id = self.kwargs.get('pk')
        convert_date = datetime.strptime(date, "%m/%d/%Y").date()
        day_of_week = convert_date.strftime("%A")

        current_date = datetime.now().date()
        current_time = datetime.now().time().strftime('%H:%M')
        convert_time = datetime.strptime(current_time, "%H:%M").time()

        if convert_date == current_date:
            match_booking = Appointment.objects.filter(date=convert_date, doctor_id=doc_pro_id,
                                                       status__in=[Appointment.Booked, Appointment.Ongoing,
                                                                   Appointment.Completed])

            exclude_data = []
            for i in match_booking:
                exclude_data.append(i.time_slot_id)

            doc_time_slot = DocTimeSlot.objects.filter(doc_id=doc_pro_id, from_time__gte=convert_time,
                                                       days=day_of_week).exclude(id__in=exclude_data)

            if not doc_time_slot:
                messages.error(request, "This date in any time slot is not available.")
                html = render_to_string(request=request, template_name='patient/time_slot.html',
                                        context={'doc_time_slot': doc_time_slot})
                return JsonResponse(data={'html': html})
            else:
                html = render_to_string(request=request, template_name='patient/time_slot.html',
                                        context={'doc_time_slot': doc_time_slot})
                return JsonResponse(data={'html': html})

        else:
            match_booking = Appointment.objects.filter(date=convert_date, doctor_id=doc_pro_id,
                                                       status__in=[Appointment.Booked, Appointment.Ongoing,
                                                                   Appointment.Completed])
            exclude_data = []
            for i in match_booking:
                exclude_data.append(i.time_slot_id)

            doc_time_slot = DocTimeSlot.objects.filter(doc_id=doc_pro_id, days=day_of_week).exclude(id__in=exclude_data)

            if not doc_time_slot:
                messages.error(request, "This date in any time slot is not available.")
                html = render_to_string(request=request, template_name='patient/time_slot.html',
                                        context={'doc_time_slot': doc_time_slot})
                return JsonResponse(data={'html': html})
            else:
                html = render_to_string(request=request, template_name='patient/time_slot.html',
                                        context={'doc_time_slot': doc_time_slot})
                return JsonResponse(data={'html': html})


class AppointmentBooking(LoginRequiredMixin, View):

    def post(self, request, *args, **kwargs):
        date = request.POST.get('selected_date')
        convert_date = datetime.strptime(date, "%m/%d/%Y").date()
        slot_id = request.POST.get('selected_slot')
        slot_data = DocTimeSlot.objects.get(id=slot_id)

        appointment = Appointment(
            hospital_id=slot_data.hospital_id,
            patient_id=request.user.patient.id,
            doctor_id=slot_data.doc_id,
            date=convert_date,
            time_slot_id=slot_id,
            created_by=request.user,
            status=Appointment.Booked
        )
        appointment.save()
        messages.success(request, 'appointment is successful booked.')
        return redirect('patient:all_hospital')


class MyAppointmentsView(LoginRequiredMixin, ListView):
    template_name = 'patient/my_appointments.html'

    def get(self, request, *args, **kwargs):
        my_appointments = Appointment.objects.filter(created_by=request.user,
                                                     status__in=[Appointment.Booked, Appointment.Cancel, Appointment.Completed]).order_by('-id')
        if my_appointments:
            return render(request, self.template_name, {'my_appointments': my_appointments})
        else:
            messages.error(request, 'you have not booked any appointment.')
        return render(request, self.template_name, {})


class CancelAppointments(LoginRequiredMixin, View):
    def post(self, request, *args, **kwargs):
        appointments_id = kwargs.get('pk')
        patient_app = Appointment.objects.get(id=appointments_id)
        patient_app.status = Appointment.Cancel
        patient_app.canceled_by = request.user
        patient_app.save()
        to_email = patient_app.doctor.user.email
        doctor_name = patient_app.doctor.user.first_name + ' ' + patient_app.doctor.user.last_name
        time_slot = str(patient_app.time_slot.from_time) + ' to ' + str(patient_app.time_slot.to_time)
        cancel_date = str(patient_app.date)
        patient_name = patient_app.patient.user.first_name

        html_content = 'hello, Dr ' + doctor_name + '<br>cancel_date:<strong>' +\
                       cancel_date + '</strong><br> time_slot:<strong>' + time_slot + '</strong><br> patient name:'\
                       + patient_name + ''
        subject = 'Appointment will cancel'
        to_mail = to_email
        msg = EmailMessage(subject, html_content, EMAIL_HOST_USER, [to_mail])
        msg.content_subtype = "html"
        msg.send()
        messages.success(request, 'appointment will be cancel.')
        return redirect('patient:my_appointments')
