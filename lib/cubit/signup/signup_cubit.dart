import 'package:auth_repo/auth_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:healthcare_partner_app/models/auth/provide_emergency_services.dart';
import 'package:healthcare_partner_app/models/auth/service_days.dart';
import 'package:healthcare_partner_app/models/auth/service_time_end.dart';
import 'package:healthcare_partner_app/models/auth/service_time_start.dart';
import 'package:healthcare_partner_app/models/auth/service_types.dart';

import '../../models/models.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit(this._authRepository) : super(SignupState());

  final AuthRepository _authRepository;

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([
        email,
        state.password,
        state.confirmedPassword,
        state.name,
        state.organization,
        state.serviceTimeStart,
        state.serviceTimeEnd,
        state.serviceDays,
        state.serviceTypes,
        state.provideEmergencyServices,
      ]),
    ));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    final confirmedPassword = ConfirmedPassword.dirty(
      password: password.value,
      value: state.confirmedPassword.value,
    );

    emit(state.copyWith(
      password: password,
      confirmedPassword: confirmedPassword,
      status: Formz.validate([
        state.email,
        password,
        state.confirmedPassword,
        state.name,
        state.organization,
        state.serviceTimeStart,
        state.serviceTimeEnd,
        state.serviceDays,
        state.serviceTypes,
        state.provideEmergencyServices,
      ]),
    ));
  }

  void confirmedPasswordChanged(String value) {
    final confirmedPassword = ConfirmedPassword.dirty(
      password: state.password.value,
      value: value,
    );
    emit(state.copyWith(
      confirmedPassword: confirmedPassword,
      status: Formz.validate([
        state.email,
        state.password,
        confirmedPassword,
        state.name,
        state.organization,
        state.serviceTimeStart,
        state.serviceTimeEnd,
        state.serviceDays,
        state.serviceTypes,
        state.provideEmergencyServices,
      ]),
    ));
  }

  void nameChanged(String value) {
    final name = NameInput.dirty(value: value);
    emit(state.copyWith(
      name: name,
      status: Formz.validate([
        state.email,
        state.password,
        state.confirmedPassword,
        name,
        state.organization,
        state.serviceTimeStart,
        state.serviceTimeEnd,
        state.serviceDays,
        state.serviceTypes,
        state.provideEmergencyServices,
      ]),
    ));
  }

  void orgChanged(String organization) {
    final org = OrganizationInput.dirty(value: organization);
    emit(state.copyWith(
      organization: org,
      status: Formz.validate([
        state.email,
        state.password,
        state.confirmedPassword,
        state.name,
        state.serviceTimeStart,
        state.serviceTimeEnd,
        state.serviceTypes,
        org,
        state.provideEmergencyServices,
        state.serviceDays,
      ]),
    ));
  }

  void serviceTypeChanged(List<String> values, List<bool> selected) {
    final serviceValues = <String>[];
    for (var i = 0; i < values.length; i++) {
      if (selected[i]) {
        serviceValues.add(values[i]);
      }
    }
    final serviceTypes = ServiceTypesInput.dirty(value: serviceValues);
    emit(state.copyWith(
      serviceTypes: serviceTypes,
      status: Formz.validate([
        state.email,
        state.password,
        state.confirmedPassword,
        state.name,
        state.organization,
        state.serviceTimeStart,
        state.serviceTimeEnd,
        state.serviceDays,
        serviceTypes,
        state.provideEmergencyServices,
      ]),
    ));
  }

  void serviceTimeStartChanged(String value) {
    final serviceTimeStart = ServiceTimeStartInput.dirty(value: value);
    emit(state.copyWith(
      serviceTimeStart: serviceTimeStart,
      status: Formz.validate([
        state.email,
        state.password,
        state.confirmedPassword,
        state.name,
        state.organization,
        serviceTimeStart,
        state.serviceTimeEnd,
        state.serviceDays,
        state.serviceTypes,
        state.provideEmergencyServices,
      ]),
    ));
  }

  void serviceTimeEndChanged(String value) {
    final serviceTimeEnd = ServiceTimeEndInput.dirty(value: value);
    emit(state.copyWith(
      serviceTimeEnd: serviceTimeEnd,
      status: Formz.validate([
        state.email,
        state.password,
        state.confirmedPassword,
        state.name,
        state.organization,
        state.serviceTimeStart,
        serviceTimeEnd,
        state.serviceDays,
        state.serviceTypes,
        state.provideEmergencyServices,
      ]),
    ));
  }

  void serviceDaysChanged(List<bool> days) {
    final _days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    var values = '';
    for (var i = 0; i < days.length; i++) {
      if (days[i]) {
        values = values + _days[i];
      }
    }
    final serviceDays = ServiceDaysInput.dirty(value: values);
    emit(state.copyWith(
      serviceDays: serviceDays,
      status: Formz.validate([
        state.email,
        state.password,
        state.confirmedPassword,
        state.name,
        state.organization,
        state.serviceTimeStart,
        state.serviceTimeEnd,
        serviceDays,
        state.serviceTypes,
        state.provideEmergencyServices,
      ]),
    ));
  }

  void provideEmergencyServicesChanged(bool value) {
    final provideEmergencyServices =
        ProvideEmergencyServicesInput.dirty(value: value);
    emit(state.copyWith(
      provideEmergencyServices: provideEmergencyServices,
      status: Formz.validate([
        state.email,
        state.password,
        state.confirmedPassword,
        state.name,
        state.organization,
        state.serviceTimeStart,
        state.serviceTimeEnd,
        state.serviceTypes,
        state.serviceDays,
        provideEmergencyServices,
      ]),
    ));
  }

  Future<void> signUpFormSubmitted() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _authRepository.signUp(
        email: state.email.value,
        password: state.password.value,
        name: state.name.value,
        organization: state.organization.value,
        provideEmergencyServices: state.provideEmergencyServices.value,
        serviceDays: state.serviceDays.value,
        serviceTimeEnd: state.serviceTimeEnd.value,
        serviceTimeStart: state.serviceTimeStart.value,
        serviceTypes: state.serviceTypes.value,
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
