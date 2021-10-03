import 'package:email_validator/email_validator.dart'
    as external_mail_valiadator;
import 'package:vitrine/domain/validation/validation_error.dart';
import 'package:vitrine/domain/validation/validator.dart';

class EmailValidator implements Validator<String> {
  const EmailValidator();
  @override
  ValidationError? call(String value) {
    return external_mail_valiadator.EmailValidator.validate(value) == true
        ? null
        : ValidationError.invalid;
  }
}
