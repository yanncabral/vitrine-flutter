import 'package:test/test.dart';
import 'package:vitrine/domain/validation/validation_error.dart';
import 'package:vitrine/domain/validation/validator.dart';

class EmailValidator implements Validator<String> {
  @override
  ValidationError? call(String value) {
    return ValidationError.invalid;
  }
}

void main() {
  group("EmailValidator", () {
    test("Should returns a ValidationError if email is invalid", () {
      final sut = EmailValidator();
      expect(sut("test"), ValidationError.invalid);
      expect(sut("test@"), ValidationError.invalid);
      expect(sut("@test.com"), ValidationError.invalid);
      expect(sut("abc-@mail.com"), ValidationError.invalid);
      expect(sut("abc..def@mail.com"), ValidationError.invalid);
      expect(sut(".abc@mail.com"), ValidationError.invalid);
      expect(sut("abc#def@mail.com"), ValidationError.invalid);
      expect(sut("@mail.com"), ValidationError.invalid);
    });
  });
}
