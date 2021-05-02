part of 'appointment_cubit.dart';

abstract class AppointmentState extends Equatable {
  const AppointmentState();

  @override
  List<Object> get props => [];
}

class AppointmentInitial extends AppointmentState {}

class AppointmentsRecieved extends AppointmentState {
  final List<Appointment> upcomingAppointments;
  final List<Appointment> pendingAppointments;

  const AppointmentsRecieved(
    this.upcomingAppointments,
    this.pendingAppointments,
  );

  @override
  List<Object> get props => [upcomingAppointments, pendingAppointments];
}
