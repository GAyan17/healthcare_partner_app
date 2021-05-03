import 'package:appointment_repository/appointment_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/cubit.dart';

class UpcomingAppointmentList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentCubit, AppointmentState>(
      builder: (context, state) {
        if (state is AppointmentsRecieved) {
          return state.upcomingAppointments.isNotEmpty
              ? ListView.builder(
                  itemCount: state.upcomingAppointments.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        onTap: () {
                          print('tapped');
                        },
                        title: Row(
                          children: [
                            Text(
                              'Appointment with:',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                                state.upcomingAppointments[index].partnerName!),
                          ],
                        ),
                        subtitle: Row(
                          children: [
                            Text(
                              'On :',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey,
                              ),
                            ),
                            Text(state
                                .upcomingAppointments[index].appointmentDateTime
                                .toString())
                          ],
                        ),
                        trailing: _AppointmentDoneButton(
                            appointment: state.upcomingAppointments[index]),
                      ),
                    );
                  },
                )
              : Center(
                  child: Text('No Appointments'),
                );
        } else {
          return Column(
            children: [
              Center(
                child: CircularProgressIndicator(),
              ),
              const SizedBox(height: 10.0),
              const Text('Loading...'),
            ],
          );
        }
      },
    );
  }
}

class _AppointmentDoneButton extends StatefulWidget {
  final Appointment appointment;

  _AppointmentDoneButton({required this.appointment});

  @override
  __AppointmentDoneButtonState createState() => __AppointmentDoneButtonState();
}

class __AppointmentDoneButtonState extends State<_AppointmentDoneButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          context.read<AppointmentCubit>().appointmentDone(widget.appointment);
        },
        child: Text('Appointment Done'));
  }
}
