part of 'signup_cubit.dart';

class SignupState extends Equatable {
  const SignupState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmedPassword = const ConfirmedPassword.pure(),
    this.status = FormzStatus.pure,
    required this.name,
    required this.dob,
    required this.organization,
    required this.provideEmergencyServices,
    required this.serviceTimeStart,
    required this.serviceTimeEnd,
    required this.serviceDays,
  });

  final Email email;
  final Password password;
  final ConfirmedPassword confirmedPassword;
  final FormzStatus status;
  final String name;
  final DateTime dob;
  final String organization;
  final bool provideEmergencyServices;
  final String serviceTimeStart;
  final String serviceTimeEnd;
  final String serviceDays;

  @override
  List<Object?> get props =>
      [email, password, confirmedPassword, status, name, dob, organization];

  SignupState copyWith({
    Email? email,
    Password? password,
    ConfirmedPassword? confirmedPassword,
    FormzStatus? status,
    String? name,
    DateTime? dob,
    String? organization,
    bool? provideEmergencyServices,
    String? serviceTimeStart,
    String? serviceTimeEnd,
    String? serviceDays,
  }) {
    return SignupState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmedPassword: confirmedPassword ?? this.confirmedPassword,
      status: status ?? this.status,
      name: name ?? this.name,
      dob: dob ?? this.dob,
      organization: organization ?? this.organization,
      provideEmergencyServices:
          provideEmergencyServices ?? this.provideEmergencyServices,
      serviceTimeStart: serviceTimeStart ?? this.serviceTimeStart,
      serviceTimeEnd: serviceTimeEnd ?? this.serviceTimeEnd,
      serviceDays: serviceDays ?? this.serviceDays,
    );
  }
}
