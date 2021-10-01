import 'package:vitrine/domain/validation/validation_error.dart';
import 'package:vitrine/domain/validation/validator.dart';

class TooShortValidator implements Validator<String> {
  final int minimumLenght;

  TooShortValidator({required this.minimumLenght}) {
    if (minimumLenght.isNegative) {
      throw RangeError.value(minimumLenght);
    }
  }

  @override
  ValidationError? call(String value) {
    if (value.length < minimumLenght) {
      return ValidationError.tooShort;
    } else {
      return null;
    }
  }
}
