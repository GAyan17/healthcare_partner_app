import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:healthcare_partner_app/util/constants.dart';

import '../../cubit/signup/signup_cubit.dart';

class SignUpForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Sign Up Failure')),
            );
        }
      },
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8.0),
            _NameInput(),
            const SizedBox(height: 8.0),
            _EmailInput(),
            const SizedBox(height: 8.0),
            _PasswordInput(),
            const SizedBox(height: 8.0),
            _ConfirmPasswordInput(),
            const SizedBox(height: 8.0),
            _OrganizationInput(),
            const SizedBox(height: 8.0),
            _ServiceTypeInput(),
            const SizedBox(height: 8.0),
            _ServiceTimeStartInput(),
            const SizedBox(height: 8.0),
            _ServiceTimeEndInput(),
            const SizedBox(height: 8.0),
            _ServiceDaysInput(),
            const SizedBox(height: 8.0),
            _EmergencyServicesInput(),
            const SizedBox(height: 8.0),
            _SignUpButton(),
          ],
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_emailInput_textField'),
          onChanged: (email) => context.read<SignupCubit>().emailChanged(email),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'Email',
            helperText: '',
            errorText: state.email.invalid ? 'Invalid Email' : null,
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<SignupCubit>().passwordChanged(password),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
            helperText: '',
            errorText: state.password.invalid ? 'Invalid Password' : null,
          ),
        );
      },
    );
  }
}

class _ConfirmPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.confirmedPassword != current.confirmedPassword,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_confirmedPasswordInput_textField'),
          onChanged: (confirmPassword) => context
              .read<SignupCubit>()
              .confirmedPasswordChanged(confirmPassword),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Confirm Password',
            helperText: '',
            errorText: state.confirmedPassword.invalid
                ? 'Passwords do not match'
                : null,
          ),
        );
      },
    );
  }
}

class _NameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return TextField(
          onChanged: (value) => context.read<SignupCubit>().nameChanged(value),
          decoration: InputDecoration(
            labelText: 'Name',
            helperText: '',
            errorText: state.name.invalid ? 'Name must not be Empty' : null,
          ),
        );
      },
    );
  }
}

class _OrganizationInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) =>
          previous.organization != current.organization,
      builder: (context, state) {
        return TextField(
          onChanged: (organization) =>
              context.read<SignupCubit>().orgChanged(organization),
          decoration: InputDecoration(
            labelText: 'Organization Name',
            helperText: '',
            errorText: state.organization.invalid
                ? 'Organization Name must not be empty'
                : null,
          ),
        );
      },
    );
  }
}

class _ServiceTypeInput extends StatefulWidget {
  @override
  __ServiceTypeInputState createState() => __ServiceTypeInputState();
}

class __ServiceTypeInputState extends State<_ServiceTypeInput> {
  final TextEditingController _controller = TextEditingController();

  final List<String> _value = [...serviceTypes];
  final List<bool> _selected =
      List.filled(serviceTypes.length, false, growable: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<Widget> buildChips(BuildContext context) {
    var chips = <Widget>[];
    for (var i = 0; i < _value.length; i++) {
      chips.add(InputChip(
        label: Text(_value[i]),
        selected: _selected[i],
        elevation: 10,
        pressElevation: 5,
        shadowColor: Colors.teal,
        onPressed: () {
          setState(() {
            _selected[i] = !_selected[i];
            context.read<SignupCubit>().serviceTypeChanged(_value, _selected);
          });
        },
        onDeleted: () {
          setState(() {
            _value.removeAt(i);
            _selected.removeAt(i);
            context.read<SignupCubit>().serviceTypeChanged(_value, _selected);
          });
        },
      ));
    }
    return chips;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      builder: (context, state) {
        return Column(
          children: [
            const Text('Services: '),
            Wrap(
              children: buildChips(context)
                ..add(IconButton(
                    onPressed: () async {
                      await showDialog(
                        context: context,
                        builder: (ctx) {
                          return AlertDialog(
                            title: Text('Add Service:'),
                            content: TextField(
                              controller: _controller,
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () => Navigator.pop(ctx),
                                child: Text('Cancel'),
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      _value.add(_controller.text);
                                      _selected.add(true);
                                      _controller.clear();
                                      context
                                          .read<SignupCubit>()
                                          .serviceTypeChanged(
                                              _value, _selected);
                                    });
                                    Navigator.pop(ctx);
                                  },
                                  child: Text('Add')),
                            ],
                          );
                        },
                      );
                    },
                    icon: Icon(Icons.add))),
            ),
          ],
        );
      },
    );
  }
}

class _ServiceTimeStartInput extends StatefulWidget {
  @override
  __ServiceTimeStartInputState createState() => __ServiceTimeStartInputState();
}

class __ServiceTimeStartInputState extends State<_ServiceTimeStartInput> {
  TimeOfDay _timeOfDay = TimeOfDay.now();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) =>
          previous.serviceTimeStart != current.serviceTimeStart,
      builder: (context, state) {
        return Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('Consultation Time Start: '),
            const SizedBox(width: 10),
            Text(_timeOfDay.format(context)),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () async {
                final pickedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay(hour: 00, minute: 00),
                  initialEntryMode: TimePickerEntryMode.input,
                  builder: (context, child) {
                    return MediaQuery(
                        data: MediaQuery.of(context)
                            .copyWith(alwaysUse24HourFormat: true),
                        child: child!);
                  },
                );

                if (pickedTime != null && pickedTime != _timeOfDay) {
                  setState(() {
                    _timeOfDay = pickedTime;
                    context
                        .read<SignupCubit>()
                        .serviceTimeStartChanged(_timeOfDay.format(context));
                  });
                }
              },
              child: Text('Set Time'),
            )
          ],
        );
      },
    );
  }
}

class _ServiceTimeEndInput extends StatefulWidget {
  @override
  __ServiceTimeEndInputState createState() => __ServiceTimeEndInputState();
}

class __ServiceTimeEndInputState extends State<_ServiceTimeEndInput> {
  TimeOfDay _timeOfDay = TimeOfDay.now();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) =>
          previous.serviceTimeEnd != current.serviceTimeEnd,
      builder: (context, state) {
        return Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('Consultation Time End: '),
            const SizedBox(width: 10),
            Text(_timeOfDay.format(context)),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () async {
                final pickedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay(hour: 00, minute: 00),
                  initialEntryMode: TimePickerEntryMode.input,
                  builder: (context, child) {
                    return MediaQuery(
                        data: MediaQuery.of(context)
                            .copyWith(alwaysUse24HourFormat: true),
                        child: child!);
                  },
                );

                if (pickedTime != null && pickedTime != _timeOfDay) {
                  setState(() {
                    _timeOfDay = pickedTime;
                    context
                        .read<SignupCubit>()
                        .serviceTimeEndChanged(_timeOfDay.format(context));
                  });
                }
              },
              child: Text('Set Time'),
            )
          ],
        );
      },
    );
  }
}

class _ServiceDaysInput extends StatefulWidget {
  @override
  __ServiceDaysInputState createState() => __ServiceDaysInputState();
}

class __ServiceDaysInputState extends State<_ServiceDaysInput> {
  final List<bool> _values = List.filled(7, false);
  final List<Text> _days = [
    Text('Monday'),
    Text('Tuesday'),
    Text('Wednesday'),
    Text('Thursday'),
    Text('Friday'),
    Text('Saturday'),
    Text('Sunday'),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      builder: (context, state) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: 7,
          itemBuilder: (context, index) {
            return CheckboxListTile(
              title: _days[index],
              value: _values[index],
              onChanged: (value) {
                setState(() {
                  _values[index] = value!;
                  context.read<SignupCubit>().serviceDaysChanged(_values);
                });
              },
            );
          },
        );
      },
    );
  }
}

class _EmergencyServicesInput extends StatefulWidget {
  @override
  __EmergencyServicesInputState createState() =>
      __EmergencyServicesInputState();
}

class __EmergencyServicesInputState extends State<_EmergencyServicesInput> {
  bool _checked = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      builder: (context, state) {
        return CheckboxListTile(
          title: Text('Do you provide 24 hrs emergency services?'),
          value: _checked,
          onChanged: (value) {
            setState(() {
              _checked = value!;
              context
                  .read<SignupCubit>()
                  .provideEmergencyServicesChanged(_checked);
            });
          },
        );
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('signUpForm_continue_raisedButton'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  // primary: Colors.orangeAccent,
                ),
                onPressed: state.status.isValidated
                    ? () => context.read<SignupCubit>().signUpFormSubmitted()
                    : null,
                child: const Text('SIGN UP'),
              );
      },
    );
  }
}
