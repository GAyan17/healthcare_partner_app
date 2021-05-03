import 'package:appointment_repository/appointment_repository.dart';
import 'package:auth_repo/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthcare_partner_app/view/home/homepage.dart';
import 'package:healthcare_partner_app/view/view.dart';

import 'bloc/app/app_bloc.dart';
import 'cubit/appointment/appointment_cubit.dart';

class App extends StatelessWidget {
  const App({Key? key, required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(key: key);

  final AuthRepository _authRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authRepository,
      child: BlocProvider(
        create: (_) => AppBloc(authRepository: _authRepository),
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
            child: AppView(),
          ),
        ),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (_) =>
            context.read<AppBloc>().state.status == AppStatus.authenticated
                ? HomePage()
                : LoginPage(),
        SignUpPage.routeName: (_) => SignUpPage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.green,
        appBarTheme: AppBarTheme(
          centerTitle: true,
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            gapPadding: 2.0,
          ),
        ),
        buttonTheme: ButtonThemeData(
          minWidth: 10.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      themeMode: ThemeMode.system,
      // home: FlowBuilder<AppStatus>(
      //   state: context.select((AppBloc bloc) => bloc.state.status),
      //   onGeneratePages: onGenerateAppViewPages,
      // ),
    );
  }
}
