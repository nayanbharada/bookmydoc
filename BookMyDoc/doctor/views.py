from django.contrib import messages
from django.contrib.auth.mixins import LoginRequiredMixin
from django.core.mail import EmailMessage
from django.shortcuts import render, redirect
from django.http import HttpResponse, JsonResponse
from django.views.generic import UpdateView, FormView, View, DeleteView, ListView
from BookMyDoc.settings import EMAIL_HOST_USER
from hospital.models import Hospital
from .forms import DoctorProfileForm, DoctorUserForm, QualificationForm, DocTimeSlotForm
from .models import DoctorProfile, DocTimeSlot, Qualification, DoctorDegree, DoctorUniversity
from django.core.exceptions import ObjectDoesNotExist
from datetime import datetime, timedelta, time, date
from doctor.models import Appointment, CheckupTiming


# Create your views here.
def index(request):
    return HttpResponse("doctor app")


class DoctorDashboardView(LoginRequiredMixin, View):
    template_name = 'doctor/doctor_dashboard.html'

    def get(self, request):
        login_doctor = request.user
        current_date = datetime.now().date()
        today_appointments = Appointment.objects.filter(date=current_date,
                                                        status__in=[Appointment.Booked, Appointment.Ongoing],
                                                        doctor_id=login_doctor.doctor_profile)
        appointment_list = Appointment.objects.filter(status=Appointment.Booked,
                                                      doctor_id=login_doctor.doctor_profile)
        # other_appointment_list = Appointment.objects.filter(status__in=[Appointment.Cancel, Appointment.Completed],
        #                                                     doctor_id=login_doctor.doctor_profile)

        return render(request, self.template_name, {'today_appointments': today_appointments,
                                                    'appointment_list': appointment_list,
                                                    })


class DoctorProfileView(LoginRequiredMixin, UpdateView):
    template_name = 'doctor/doc_profile.html'
    form_class = DoctorProfileForm
    second_form_class = DoctorUserForm

    def get(self, request, *args, **kwargs):
        doc_profile = DoctorProfile.objects.get(user_id=request.user.id)
        form = self.form_class(instance=doc_profile)
        user_form = self.second_form_class(instance=request.user)
        return render(request, self.template_name, {'form': form, 'user_form': user_form})

    def post(self, request, *args, **kwargs):
        doc_profile = DoctorProfile.objects.get(user_id=request.user.id)
        form = self.form_class(request.POST, instance=doc_profile)
        user_form = self.second_form_class(request.POST, request.FILES, instance=request.user)
        if form.is_valid() and user_form.is_valid():
            form.save()
            user_form.save()
            messages.success(request, 'Your profile will be update.')
            return redirect('doctor:dashboard')
        else:
            return render(request, self.template_name, {'form': form, 'user_form': user_form})


class QualificationView(LoginRequiredMixin, FormView):
    template_name = 'doctor/doc_qualification.html'
    form_class = QualificationForm

    def get(self, request, *args, **kwargs):
        form = self.form_class
        doctor_profile_id = request.user.doctor_profile.id
        doctor_qualifications = Qualification.objects.filter(doctor_profile_id=doctor_profile_id)
        return render(request, self.template_name, {'form': form, 'doctor_qualifications': doctor_qualifications})

    def post(self, request, *args, **kwargs):
        login_doctor = request.user
        form = self.form_class(request.POST)
        doctor = login_doctor.doctor_profile
        if form.is_valid():
            degree = form.cleaned_data.get('degree')
            if Qualification.objects.filter(degree=degree, doctor_profile_id=doctor.id).exists():
                messages.error(request, 'Your degree all_ready exists.')
                return redirect('doctor:doc_qualification')
            else:
                instance = form.save(commit=False)
                instance.doctor_profile_id = doctor.id
                instance.save()
                messages.success(request, 'Your qualification add successful.')
                return redirect('doctor:doc_qualification')
        else:
            return render(request, self.template_name, {'form': form})


class DeleteDocQualification(LoginRequiredMixin, DeleteView):
    model = Qualification

    def get(self, request, **kwargs):
        doc_qualification_id = kwargs.get('pk')
        doc_qualification = Qualification.objects.get(id=doc_qualification_id)
        doc_qualification.delete()
        messages.success(request, 'Delete successful.')
        return redirect('doctor:doc_qualification')


class EditDocQualification(LoginRequiredMixin, UpdateView):
    template_name = 'doctor/edit_doc_qualification.html'
    form_class = QualificationForm

    def get(self, request, **kwargs):
        qualification_id = kwargs.get('pk')
        qualification_obj = Qualification.objects.get(id=qualification_id)
        degree = DoctorDegree.objects.get(degree=qualification_obj.degree)
        university = DoctorUniversity.objects.get(university_name=qualification_obj.university)
        form = self.form_class(initial={'degree': degree, 'university': university})

        return render(request, self.template_name, {'form': form})

    def post(self, request, *args, **kwargs):
        qualification_id = kwargs.get('pk')
        qualification_obj = Qualification.objects.get(id=qualification_id)
        form = self.form_class(request.POST, instance=qualification_obj)
        if form.is_valid():
            degree = form.cleaned_data.get('degree')
            if Qualification.objects.filter(degree=degree,
                                            doctor_profile_id=qualification_obj.doctor_profile_id).exists():
                messages.error(request, 'Your degree all_ready exists.')
                return redirect('doctor:doc_qualification')
            else:
                form.save()
                messages.success(request, 'Your qualification update successful.')
                return redirect('doctor:doc_qualification')
        else:
            return render(request, self.template_name, {'form': form})


class DocTimeSlotView(LoginRequiredMixin, FormView):
    form_class = DocTimeSlotForm
    template_name = 'doctor/doc_time_slot.html'

    def get(self, request, *args, **kwargs):
        form = self.form_class
        user = request.user

        doc_time_slot = DocTimeSlot.objects.filter(doc_id=user.doctor_profile.id)

        return render(request, self.template_name, {'form': form, 'doc_time_slot': doc_time_slot})

    def post(self, request, *args, **kwargs):
        form = self.form_class(request.POST)
        user = request.user

        if form.is_valid():
            days = form.cleaned_data.get('days')
            from_time = form.cleaned_data.get('from_time')
            to_time = form.cleaned_data.get('to_time')

            try:
                data = DocTimeSlot.objects.get(doc_id=user.doctor_profile.id,
                                               days=days,
                                               from_time=from_time,
                                               to_time=to_time)
            except ObjectDoesNotExist:
                data = None

            if data is None:
                instance = form.save(commit=False)
                instance.doc_id = user.doctor_profile.id
                instance.hospital_id = user.doctor_profile.hospital_id
                instance.save()
                doc_time_slot = DocTimeSlot.objects.filter(doc_id=user.doctor_profile.id)
                messages.success(request, 'Doctor time slot will be add.')
                return render(request, self.template_name, {'form': self.form_class,
                                                            'doc_time_slot': doc_time_slot})
            else:
                doc_time_slot = DocTimeSlot.objects.filter(doc_id=user.doctor_profile.id)
                messages.error(request, 'This time slot is all_ready add.')
                return render(request, self.template_name, {'form': self.form_class,
                                                            'doc_time_slot': doc_time_slot})
        else:
            doc_time_slot = DocTimeSlot.objects.filter(doc_id=user.doctor_profile.id)
            return render(request, self.template_name, {'form': form, 'doc_time_slot': doc_time_slot})


class EditDocTimeSlot(LoginRequiredMixin, UpdateView):
    form_class = DocTimeSlotForm
    template_name = 'doctor/doc_time_slot.html'
    model = DocTimeSlot

    def post(self, request, *args, **kwargs):
        edit_time_slot = DocTimeSlot.objects.get(id=self.kwargs.get('pk'))
        form = self.form_class(request.POST, instance=edit_time_slot)
        user = request.user
        if form.is_valid():
            days = form.cleaned_data.get('days')
            from_time = form.cleaned_data.get('from_time')
            to_time = form.cleaned_data.get('to_time')

            try:
                data = DocTimeSlot.objects.get(doc_id=user.doctor_profile.id,
                                               days=days,
                                               from_time=from_time,
                                               to_time=to_time)
            except ObjectDoesNotExist:
                data = None

            if data is None:
                form.save()
                doc_time_slot = DocTimeSlot.objects.filter(doc_id=user.doctor_profile.id)
                messages.success(request, 'Time slot update successfully.')
                return render(request, self.template_name, {'form': self.form_class,
                                                            'doc_time_slot': doc_time_slot})
            else:
                messages.error(request, 'This time slot is all_ready add.')
                return render(request, self.template_name, {'form': form})
        else:
            return render(request, self.template_name, {'form': form})


class DeleteDocTimeSlot(LoginRequiredMixin, DeleteView):
    model = DocTimeSlot

    def get(self, request, *args, **kwargs):
        doc_time_slot_id = kwargs.get('pk')
        doc_time_slot_obj = DocTimeSlot.objects.get(id=doc_time_slot_id)
        doc_time_slot_obj.delete()
        messages.success(request, 'Delete successful.')
        return redirect('doctor:doc_time_slot')


class TodayAppointments(LoginRequiredMixin, View):
    template_name = 'doctor/today_appointments.html'

    def get(self, request):
        login_doctor = request.user
        current_date = datetime.now().date()
        today_appointment_list = Appointment.objects.filter(date=current_date,
                                                            status__in=[Appointment.Booked, Appointment.Ongoing],
                                                            doctor_id=login_doctor.doctor_profile)

        return render(request, self.template_name, {'today_appointment_list': today_appointment_list})


class CancelTodayAppointments(View):
    template_name = 'doctor/today_appointments.html'

    def post(self, request, **kwargs):
        appointment_id = kwargs.get('pk')
        appointment_obj = Appointment.objects.get(id=appointment_id)
        appointment_obj.status = Appointment.Cancel
        appointment_obj.canceled_by = request.user
        appointment_obj.save()
        if appointment_obj.created_by.is_type == "hospital":
            messages.success(request, 'Appointment will be cancel')
            return redirect('doctor:today_appointments')
        else:
            doctor_name = appointment_obj.doctor.user.first_name + ' ' + appointment_obj.doctor.user.last_name
            time_slot = str(appointment_obj.time_slot.from_time) + ' to ' + str(appointment_obj.time_slot.to_time)
            cancel_date = str(appointment_obj.date)
            patient_name = appointment_obj.patient.user.first_name
            to_email = appointment_obj.patient.user.email

            html_content = 'hello,  dear ' + patient_name + \
                           '<br> Your appointment will be cancel. cancel_by <strong>Dr ' \
                           + doctor_name + '</strong><br>appointment_date:<strong>' + \
                           cancel_date + '</strong><br> time_slot:<strong>' + time_slot + '</strong><br>'
            subject = 'Appointment will cancel'
            to_mail = to_email
            msg = EmailMessage(subject, html_content, EMAIL_HOST_USER, [to_mail])
            msg.content_subtype = "html"
            msg.send()
            messages.success(request, 'Appointment will be cancel.')

        return redirect('doctor:today_appointments')


class ChangeAppointmentStatus(LoginRequiredMixin, View):
    def get(self, request):
        appointment_id = request.GET.get("appointment_id")
        current_time = datetime.now().time().strftime('%H:%M')
        convert_time = datetime.strptime(current_time, "%H:%M").time()
        appointment_obj = Appointment.objects.get(id=appointment_id)
        appointment_obj.status = Appointment.Completed
        appointment_obj.save()
        checkup_timing_obj = CheckupTiming.objects.get(appointment_id=appointment_obj.id)
        checkup_timing_obj.check_out = convert_time
        checkup_timing_obj.save()
        return HttpResponse("success")

    def post(self, request):
        appointment_id = request.POST.get('appointment_id')

        if CheckupTiming.objects.filter(appointment_id=appointment_id).exists():

            return JsonResponse({'message': 'you not enter'})
        else:
            current_date = datetime.now().date()
            current_time = datetime.now().time().strftime('%H:%M')
            convert_time = datetime.strptime(current_time, "%H:%M").time()
            appointment_obj = Appointment.objects.get(id=appointment_id)
            appointment_obj.status = Appointment.Ongoing
            appointment_obj.save()
            check_up_timing = CheckupTiming(
                appointment_id=appointment_obj.id,
                doc_id=appointment_obj.doctor_id,
                date=current_date,
                check_in=convert_time
            )
            check_up_timing.save()
            return JsonResponse({'message': 'success'})


class CheckStatus(LoginRequiredMixin, View):
    def get(self, request):
        appointment_id = request.GET.get('appointment_id')
        if CheckupTiming.objects.filter(appointment_id=appointment_id).exists():
            return JsonResponse({'message': 'false'})
        else:
            return JsonResponse({'message': 'true'})


class AllAppointments(LoginRequiredMixin, View):
    template_name = 'doctor/all_appointments.html'
    model = Appointment

    def get(self, request):
        login_doctor = request.user
        current_date = datetime.now().date()
        appointment_list = Appointment.objects.filter(status__in=[Appointment.Booked, Appointment.Cancel,
                                                                  Appointment.Completed],
                                                      doctor_id=login_doctor.doctor_profile)
        return render(request, self.template_name, {'appointment_list': appointment_list})


class StatusFilter(LoginRequiredMixin, ListView):
    template_name = 'doctor/all_appointments.html'
    model = Appointment

    def get_queryset(self):
        login_doctor = self.request.user
        current_date = datetime.now().date()
        status = self.request.GET.get("status_filter")
        print(status)
        appointment_list = Appointment.objects.filter(status=status,
                                                      doctor_id=login_doctor.doctor_profile)
        return appointment_list


class ShowCheckupTiming(LoginRequiredMixin, View):

    def get(self, request, **kwargs):
        appointment_id = request.GET.get('appointment_id')
        # print(appointment_id)
        data = dict()
        CheckupTiming_obj = CheckupTiming.objects.get(appointment_id=appointment_id)
        check_in_time = CheckupTiming_obj.check_in
        check_out_time = CheckupTiming_obj.check_out
        duration = datetime.combine(date.min, check_out_time) - datetime.combine(date.min, check_in_time)
        print(duration)
        h = duration.seconds // 3600
        print(h)
        m = (duration.seconds % 3600) // 60
        print(m)
        sec = (duration.seconds % 3600) % 60
        print(sec)
        # print(CheckupTiming_obj.check_in)
        # print(CheckupTiming_obj.check_out)
        # minutes = duration.seconds / 60
        # print(minutes)
        # hours = duration.seconds / 3600
        # print(hours)
        data['duration_hour'] = h
        data['duration_minute'] = m
        data['duration_sec'] = sec
        return JsonResponse(data)


class CancelAppointments(LoginRequiredMixin, View):
    def post(self, request, **kwargs):
        appointment_id = kwargs.get('pk')
        appointment_obj = Appointment.objects.get(id=appointment_id)
        appointment_obj.status = Appointment.Cancel
        appointment_obj.canceled_by = request.user
        appointment_obj.save()
        if appointment_obj.created_by.is_type == "hospital":
            messages.success(request, 'Appointment will be cancel')
            return redirect('doctor:all_appointments')
        else:
            doctor_name = appointment_obj.doctor.user.first_name + ' ' + appointment_obj.doctor.user.last_name
            time_slot = str(appointment_obj.time_slot.from_time) + ' to ' + str(appointment_obj.time_slot.to_time)
            cancel_date = str(appointment_obj.date)
            patient_name = appointment_obj.patient.user.first_name
            to_email = appointment_obj.patient.user.email

            html_content = 'hello,  dear ' + patient_name + \
                           '<br> Your appointment will be cancel. cancel_by <strong>Dr ' \
                           + doctor_name + '</strong><br>appointment_date:<strong>' + \
                           cancel_date + '</strong><br> time_slot:<strong>' + time_slot + '</strong><br>'
            subject = 'Appointment will cancel'
            to_mail = to_email
            msg = EmailMessage(subject, html_content, EMAIL_HOST_USER, [to_mail])
            msg.content_subtype = "html"
            msg.send()
            messages.success(request, 'Appointment will be cancel.')

        return redirect('doctor:all_appointments')


class OtherAppointmentView(LoginRequiredMixin, ListView):
    template_name = 'doctor/other_appointments.html'

    def get(self, request, *args, **kwargs):
        login_doctor = request.user
        other_appointment_list = Appointment.objects.filter(status__in=[Appointment.Completed, Appointment.Cancel],
                                                            doctor_id=login_doctor.doctor_profile)
        return render(request, self.template_name, {'other_appointment_list': other_appointment_list})


class PatientMedicalHistory(LoginRequiredMixin, View):
    template_name = 'doctor/patient_medical_history.html'

    def get(self, request, **kwargs):
        appointment_id = kwargs.get('pk')
        appointment_obj = Appointment.objects.get(id=appointment_id)
        return render(request, self.template_name, {'appointment_obj': appointment_obj})


class AllHospitalView(LoginRequiredMixin, ListView):
    template_name = 'doctor/all_hospital.html'
    model = Hospital
    context_object_name = 'all_hospital'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        return context


class DoctorListView(LoginRequiredMixin, ListView):
    template_name = 'doctor/doctor_list.html'

    def get(self, request, *args, **kwargs):
        hospital_id = self.kwargs.get('pk')
        doc_lists = DoctorProfile.objects.filter(hospital_id=hospital_id)
        hospital_obj = Hospital.objects.get(id=hospital_id)
        return render(request, self.template_name, {'doc_lists': doc_lists, 'hospital_obj': hospital_obj})
