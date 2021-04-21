import 'package:auth_repo/auth_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:healthcare_partner_app/models/models.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit(this._authRepository)
      : super(
          SignupState(
            name: '',
            dob: DateTime.now(),
            organization: '',
            provideEmergencyServices: false,
            serviceTimeStart: '',
            serviceTimeEnd: '',
            serviceDays: '',
          ),
        );

  final AuthRepository _authRepository;

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([
        email,
        state.password,
        state.confirmedPassword,
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
      ]),
    ));
  }

  void nameChanged(String value) {
    emit(state.copyWith(name: value));
  }

  void dobChanged(DateTime dob) {
    emit(state.copyWith(dob: dob));
  }

  void orgChanged(String organization) {
    emit(state.copyWith(organization: organization));
  }

  void serviceTimeStartChanged(String serviceTimeStart) {
    emit(state.copyWith(serviceTimeStart: serviceTimeStart));
  }

  void serviceTimeEndChanged(String serviceTimeEnd) {
    emit(state.copyWith(serviceTimeEnd: serviceTimeEnd));
  }

  void serviceDaysChanged(List<bool> days) {
    final _days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    var serviceDays = '';
    for (var i = 0; i < days.length; i++) {
      if (days[i]) {
        serviceDays = serviceDays + _days[i];
      }
    }
    emit(state.copyWith(serviceDays: serviceDays));
  }

  void provideEmergencyServicesChanged(bool provideEmergencyServices) {
    emit(state.copyWith(provideEmergencyServices: provideEmergencyServices));
  }

  Future<void> signUpFormSubmitted() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _authRepository.signUp(
        email: state.email.value,
        password: state.password.value,
        name: state.name,
        dob: state.dob,
        organization: state.organization,
        provideEmergencyServices: state.provideEmergencyServices,
        serviceDays: state.serviceDays,
        serviceTimeEnd: state.serviceTimeEnd,
        serviceTimeStart: state.serviceTimeStart,
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
