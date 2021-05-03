part of 'signup_cubit.dart';

class SignupState extends Equatable {
  const SignupState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmedPassword = const ConfirmedPassword.pure(),
    this.status = FormzStatus.pure,
    this.name = const NameInput.pure(),
    this.organization = const OrganizationInput.pure(),
    this.serviceTypes = const ServiceTypesInput.pure(),
    this.provideEmergencyServices = const ProvideEmergencyServicesInput.pure(),
    this.serviceTimeStart = const ServiceTimeStartInput.pure(),
    this.serviceTimeEnd = const ServiceTimeEndInput.pure(),
    this.serviceDays = const ServiceDaysInput.pure(),
  });

  final Email email;
  final Password password;
  final ConfirmedPassword confirmedPassword;
  final FormzStatus status;
  final NameInput name;
  final OrganizationInput organization;
  final ProvideEmergencyServicesInput provideEmergencyServices;
  final ServiceTypesInput serviceTypes;
  final ServiceTimeStartInput serviceTimeStart;
  final ServiceTimeEndInput serviceTimeEnd;
  final ServiceDaysInput serviceDays;

  @override
  List<Object?> get props => [
        email,
        password,
        confirmedPassword,
        status,
        name,
        organization,
        provideEmergencyServices,
        serviceTypes,
        serviceTimeStart,
        serviceTimeEnd,
        serviceDays,
      ];

  SignupState copyWith({
    Email? email,
    Password? password,
    ConfirmedPassword? confirmedPassword,
    FormzStatus? status,
    NameInput? name,
    OrganizationInput? organization,
    ProvideEmergencyServicesInput? provideEmergencyServices,
    ServiceTypesInput? serviceTypes,
    ServiceTimeStartInput? serviceTimeStart,
    ServiceTimeEndInput? serviceTimeEnd,
    ServiceDaysInput? serviceDays,
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
