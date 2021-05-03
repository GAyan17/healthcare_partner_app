import 'package:formz/formz.dart';

enum ServiceTimeEndInputError { empty }

class ServiceTimeEndInput extends FormzInput<String, ServiceTimeEndInputError> {
  const ServiceTimeEndInput.pure() : super.pure('');

  const ServiceTimeEndInput.dirty({String value = ''}) : super.dirty(value);

  @override
  ServiceTimeEndInputError? validator(String? value) {
    return value?.isNotEmpty == true ? null : ServiceTimeEndInputError.empty;
  }
}
