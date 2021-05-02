import 'package:appointment_repository/appointment_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/cubit.dart';

class PendingAppointmentList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentCubit, AppointmentState>(
      builder: (context, state) {
        if (state is AppointmentsRecieved) {
          return state.pendingAppointments.isNotEmpty
              ? ListView.builder(
                  itemCount: state.pendingAppointments.length,
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
                            Text(state.pendingAppointments[index].patientName!),
                          ],
                        ),
                        subtitle: Row(
                          children: [
                            Text(
                              'Symptoms :',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey,
                              ),
                            ),
                            Text(state.pendingAppointments[index].symptoms!)
                          ],
                        ),
                        trailing: _ConfirmAppointmentButton(
                          appointment: state.pendingAppointments[index],
                        ),
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

class _ConfirmAppointmentButton extends StatefulWidget {
  final Appointment appointment;

  const _ConfirmAppointmentButton({Key? key, required this.appointment})
      : super(key: key);

  @override
  __ConfirmAppointmentButtonState createState() =>
      __ConfirmAppointmentButtonState();
}

class __ConfirmAppointmentButtonState extends State<_ConfirmAppointmentButton> {
  DateTime _appointmentDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: Text('Set Appointment Date'),
                content: Text(_appointmentDate.toString().split(":")[0]),
                actions: [
                  ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Cancel')),
                  ElevatedButton(
                      onPressed: () async {
                        _appointmentDate = (await showDatePicker(
                            context: context,
                            initialDate: DateTime(2000),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2050),
                            initialEntryMode: DatePickerEntryMode.input))!;
                        context.read<AppointmentCubit>().changeAppointmentDate(
                            widget.appointment, _appointmentDate);
                      },
                      child: Text('Set Date')),
                ],
              );
            },
          );
        },
        child: Text('Confirm Appointment'));
  }
}
