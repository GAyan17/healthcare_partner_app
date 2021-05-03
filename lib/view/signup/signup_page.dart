import 'package:auth_repo/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/cubit.dart';
import 'signup_form.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  static const String routeName = '/sign_up_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Sign Up',
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocProvider<SignupCubit>(
            create: (_) => SignupCubit(context.read<AuthRepository>()),
            child: SignUpForm(),
          ),
        ),
      ),
    );
  }
}
