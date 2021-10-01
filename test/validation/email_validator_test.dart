import 'package:email_validator/email_validator.dart'
    as external_mail_valiadator;
import 'package:faker/faker.dart';
import 'package:test/test.dart';
import 'package:vitrine/domain/validation/validation_error.dart';
import 'package:vitrine/domain/validation/validator.dart';

class EmailValidator implements Validator<String> {
  @override
  ValidationError? call(String value) {
    return external_mail_valiadator.EmailValidator.validate(value) == true
        ? null
        : ValidationError.invalid;
  }
}

void main() {
  final faker = Faker();
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
    test("Should returns null if email is valid", () {
      final sut = EmailValidator();
      expect(sut("yann@gmail.com"), null);
      expect(sut(faker.internet.email()), null);
      expect(sut(faker.internet.freeEmail()), null);
      expect(sut(faker.internet.safeEmail()), null);
    });
  });
}
