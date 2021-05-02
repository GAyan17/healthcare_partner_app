import 'package:appointment_repository/appointment_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthcare_partner_app/cubit/cubit.dart';

import '../../bloc/app/app_bloc.dart';
import 'appointment_list.dart';
import 'pending_appointment_list.dart';

class HomePage extends StatelessWidget {
  static Page page() => MaterialPage<void>(
        child: MultiRepositoryProvider(
          providers: [
            RepositoryProvider(
              create: (_) => AppointmentRepository(),
            ),
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => AppointmentCubit(
                    context.read<AppointmentRepository>(),
                    context.read<AppBloc>().state.user.id),
              )
            ],
            child: HomePage(),
          ),
        ),
      );

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
