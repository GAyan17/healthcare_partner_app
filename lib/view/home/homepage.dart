import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/app/app_bloc.dart';
import 'appointment_list.dart';
import 'pending_appointment_list.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final user = context.select((AppBloc bloc) => bloc.state.user);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text('Welcome, ${user.name}'),
            actions: <Widget>[
              IconButton(
                key: const Key('homePage_logout_iconButton'),
                icon: const Icon(Icons.exit_to_app),
                onPressed: () =>
                    context.read<AppBloc>().add(AppLogOutRequested()),
              )
            ],
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: const Icon(Icons.book_rounded),
                  child: const Text('Pending Appointments'),
                ),
                Tab(
                  icon: const Icon(Icons.timelapse),
                  child: const Text('Upcoming Appointments'),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              PendingAppointmentList(),
              UpcomingAppointmentList(),
            ],
          )),
    );
  }
}
