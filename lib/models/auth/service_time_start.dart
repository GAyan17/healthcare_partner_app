import 'package:formz/formz.dart';

enum ServiceTimeStartInputError { empty }

class ServiceTimeStartInput
    extends FormzInput<String, ServiceTimeStartInputError> {
  const ServiceTimeStartInput.pure() : super.pure('');

  const ServiceTimeStartInput.dirty({String value = ''}) : super.dirty(value);

  @override
  ServiceTimeStartInputError? validator(String? value) {
    return value?.isNotEmpty == true ? null : ServiceTimeStartInputError.empty;
  }
}
