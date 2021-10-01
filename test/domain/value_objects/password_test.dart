import 'package:test/test.dart';
import 'package:vitrine/domain/validation/validation_error.dart';
import 'package:vitrine/domain/validation/validator.dart';
import 'package:vitrine/domain/value_objects/value_object.dart';
import 'package:vitrine/validation/not_empty_validator.dart';
import 'package:vitrine/validation/too_short_validator.dart';

class Password extends ValueObject<String> {
  Password(String data) : super(data) {
    if (validationError != null) {
      throw validationError!;
    }
  }

  @override
  List<Validator> get validators => [
        NotEmptyValidator(),
        TooShortValidator(minimumLenght: 8),
      ];
}

void main() {
  group("Password", () {
    test(
        "Should throws a ValidationError.tooShort if password is shorter than 8 characters",
        () {
      expect(() => Password("1234"), throwsA(ValidationError.tooShort));
    });
    test("Should returns an instance if password lenght has 8 characters", () {
      expect(Password("12345678"), isA<Password>());
    });

    test(
        "Should returns an instance if password lenght is longer than 8 characters",
        () {
      expect(Password("123456789#"), isA<Password>());
    });

    test("Should throws a ValidationError.empty if password is empty", () {
      expect(() => Password(""), throwsA(ValidationError.empty));
    });
  });
}
