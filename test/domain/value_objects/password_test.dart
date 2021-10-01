import 'package:test/test.dart';
import 'package:vitrine/domain/validation/validation_error.dart';
import 'package:vitrine/domain/validation/validator.dart';
import 'package:vitrine/domain/value_objects/value_object.dart';
import 'package:vitrine/validation/too_short_validator.dart';

class Password extends ValueObject<String> {
  Password(String data) : super(data) {
    if (validationError != null) {
      throw validationError!;
    }
  }

  @override
  List<Validator> get validators => [TooShortValidator(minimumLenght: 8)];
}

void main() {
  group("Password", () {
    test(
        "Should throws a ValidationError.tooShort if password is shorter then 6 characters",
        () {
      expect(() => Password("1234"), throwsA(ValidationError.tooShort));
    });
  });
}
