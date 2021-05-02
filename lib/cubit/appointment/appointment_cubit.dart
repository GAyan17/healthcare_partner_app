import 'dart:async';

import 'package:appointment_repository/appointment_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'appointment_state.dart';

class AppointmentCubit extends Cubit<AppointmentState> {
  AppointmentCubit(this._appointmentRepository, this.partnerId)
      : super(AppointmentInitial()) {
    _appointmentSubscription = _appointmentRepository
        .getAppointments(partnerId)
        .listen(_onAppointmentsRecieved);
  }

  final String partnerId;
  final AppointmentRepository _appointmentRepository;
  late final StreamSubscription _appointmentSubscription;

  void _onAppointmentsRecieved(List<Appointment> appointments) {
    final today = DateTime.now();
    final upcomingAppointments = <Appointment>[];
    final pendingAppointments = <Appointment>[];
    appointments.forEach((apt) {
      if (apt.appointmentStatus == 'Pending') {
        pendingAppointments.add(apt);
      } else if (apt.appointmentDateTime!
          .isAfter(DateTime(today.year, today.month, today.day))) {
        upcomingAppointments.add(apt);
      }
    });
    emit(AppointmentsRecieved(upcomingAppointments, pendingAppointments));
  }

  Future<void> createAppointment(Appointment appointment) async {
    await _appointmentRepository.createAppointment(appointment);
  }

  Future<void> changeAppointmentStatusToRecieved(
      Appointment appointment) async {
    await _appointmentRepository
        .updateAppointment(appointment.copyWith(appointmentStatus: 'Recieved'));
  }

  Future<void> changeAppointmentDate(
      Appointment appointment, DateTime appointmentDateTime) async {
    await _appointmentRepository.updateAppointment(appointment.copyWith(
        appointmentDateTime: appointmentDateTime,
        appointmentStatus: 'Confirmed'));
  }

  @override
  Future<void> close() {
    _appointmentSubscription.cancel();
    return super.close();
  }
}
