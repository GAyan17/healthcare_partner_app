part of 'signup_cubit.dart';

class SignupState extends Equatable {
  const SignupState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmedPassword = const ConfirmedPassword.pure(),
    this.status = FormzStatus.pure,
    this.name = const NameInput.pure(),
    this.organization = const OrganizationInput.pure(),
    required this.serviceTypes,
    required this.provideEmergencyServices,
    required this.serviceTimeStart,
    required this.serviceTimeEnd,
    required this.serviceDays,
  });

  final Email email;
  final Password password;
  final ConfirmedPassword confirmedPassword;
  final FormzStatus status;
  final NameInput name;
  final OrganizationInput organization;
  final bool provideEmergencyServices;
  final List<String> serviceTypes;
  final String serviceTimeStart;
  final String serviceTimeEnd;
  final String serviceDays;

  @override
  List<Object?> get props =>
      [email, password, confirmedPassword, status, name, organization];

  SignupState copyWith({
    Email? email,
    Password? password,
    ConfirmedPassword? confirmedPassword,
    FormzStatus? status,
    NameInput? name,
    OrganizationInput? organization,
    bool? provideEmergencyServices,
    List<String>? serviceTypes,
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
      organization: organization ?? this.organization,
      provideEmergencyServices:
          provideEmergencyServices ?? this.provideEmergencyServices,
      serviceTimeStart: serviceTimeStart ?? this.serviceTimeStart,
      serviceTimeEnd: serviceTimeEnd ?? this.serviceTimeEnd,
      serviceDays: serviceDays ?? this.serviceDays,
      serviceTypes: serviceTypes ?? this.serviceTypes,
    );
  }
}
