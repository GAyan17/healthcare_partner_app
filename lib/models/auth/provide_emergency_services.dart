import 'package:formz/formz.dart';

enum ProvideEmergencyServicesError { empty }

class ProvideEmergencyServicesInput
    extends FormzInput<bool, ProvideEmergencyServicesError> {
  const ProvideEmergencyServicesInput.pure() : super.pure(false);

  const ProvideEmergencyServicesInput.dirty({bool value = false})
      : super.dirty(value);

  @override
  ProvideEmergencyServicesError? validator(bool? value) {
    return null;
  }
}
