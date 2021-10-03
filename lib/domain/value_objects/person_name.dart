import 'package:vitrine/domain/validation/validator.dart';
import 'package:vitrine/domain/value_objects/value_object.dart';
import 'package:vitrine/validation/not_empty_validator.dart';
import 'package:vitrine/validation/too_short_validator.dart';

class PersonName extends ValueObject<String> {
  PersonName(String data) : super(data) {
    if (validationError != null) {
      throw validationError!;
    }
  }

  @override
  List<Validator> get validators => [
        const NotEmptyValidator(),
        TooShortValidator(minimumLenght: 2),
      ];
}
