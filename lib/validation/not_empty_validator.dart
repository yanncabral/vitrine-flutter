import 'package:vitrine/domain/validation/validation_error.dart';
import 'package:vitrine/domain/validation/validator.dart';

class NotEmptyValidator implements Validator<String> {
  @override
  ValidationError? call(String value) {
    if (value.isEmpty) {
      return ValidationError.empty;
    } else {
      return null;
    }
  }
}
