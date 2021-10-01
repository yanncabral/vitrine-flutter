import 'package:vitrine/domain/validation/validator.dart';
import 'package:vitrine/domain/value_objects/value_object.dart';
import 'package:vitrine/validation/email_validator.dart';

class EmailAddress extends ValueObject<String> {
  EmailAddress(String data) : super(data) {
    if (validationError != null) {
      throw validationError!;
    }
  }

  @override
  List<Validator> get validators => [EmailValidator()];
}
