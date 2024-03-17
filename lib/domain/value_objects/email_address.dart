import 'package:vitrine/domain/validation/validator.dart';
import 'package:vitrine/domain/value_objects/value_object.dart';
import 'package:vitrine/validation/email_validator.dart';

class EmailAddress extends ValueObject<String> {
  @override
  final List<Validator> validators;

  EmailAddress(super.data, {this.validators = const [EmailValidator()]}) {
    if (validationError != null) {
      throw validationError!;
    }
  }
}
