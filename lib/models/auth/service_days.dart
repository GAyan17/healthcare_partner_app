import 'package:formz/formz.dart';

enum ServiceDaysInputError { empty }

class ServiceDaysInput extends FormzInput<String, ServiceDaysInputError> {
  const ServiceDaysInput.pure() : super.pure('');

  const ServiceDaysInput.dirty({String value = ''}) : super.dirty(value);

  @override
  ServiceDaysInputError? validator(String? value) {
    return value?.isNotEmpty == true ? null : ServiceDaysInputError.empty;
  }
}
