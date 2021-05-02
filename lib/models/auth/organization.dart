import 'package:formz/formz.dart';

enum OrganizationInputError { empty }

class OrganizationInput extends FormzInput<String, OrganizationInputError> {
  const OrganizationInput.pure() : super.pure('');

  const OrganizationInput.dirty({String value = ''}) : super.dirty(value);

  @override
  OrganizationInputError? validator(String? value) {
    return value?.isNotEmpty == true ? null : OrganizationInputError.empty;
  }
}
