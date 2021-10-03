import 'package:faker/faker.dart';
import 'package:test/test.dart';
import 'package:vitrine/domain/validation/validation_error.dart';
import 'package:vitrine/validation/email_validator.dart';

void main() {
  final faker = Faker();
  const sut = EmailValidator();
  group("EmailValidator", () {
    test("Should returns a ValidationError if email is invalid", () {
      expect(sut("test"), ValidationError.invalid);
      expect(sut("test@"), ValidationError.invalid);
      expect(sut("@test.com"), ValidationError.invalid);
      expect(sut("abc..def@mail.com"), ValidationError.invalid);
      expect(sut(".abc@mail.com"), ValidationError.invalid);
      expect(sut("@mail.com"), ValidationError.invalid);
    });
    test("Should returns null if email is valid", () {
      expect(sut("yann@gmail.com"), null);
      expect(sut(faker.internet.email()), null);
      expect(sut(faker.internet.freeEmail()), null);
      expect(sut(faker.internet.safeEmail()), null);
    });
  });
}
