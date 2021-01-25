from .models import Appointment, User
from datetime import datetime


def status_change():
    superusers = User.objects.filter(is_superuser=True).first()
    current_date = datetime.now().date()
    appointment = Appointment.objects.filter(date=current_date, status=Appointment.Booked)
    appointment.update(status=Appointment.Cancel, canceled_by_id=superusers.id)
