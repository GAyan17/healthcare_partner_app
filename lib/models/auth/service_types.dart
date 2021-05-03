import 'package:formz/formz.dart';

enum ServiceTypesInputError { empty }

class ServiceTypesInput
    extends FormzInput<List<String>, ServiceTypesInputError> {
  const ServiceTypesInput.pure() : super.pure(const <String>[]);

  const ServiceTypesInput.dirty({List<String> value = const []})
      : super.dirty(value);

  @override
  ServiceTypesInputError? validator(List<String>? value) {
    return value?.isNotEmpty == true ? null : ServiceTypesInputError.empty;
  }
}
