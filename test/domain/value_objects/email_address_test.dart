import 'package:faker/faker.dart';
import 'package:test/test.dart';
import 'package:vitrine/domain/validation/validation_error.dart';
import 'package:vitrine/domain/value_objects/email_address.dart';

void main() {
  final faker = Faker();
  group("EmailAddress", () {
    test("Should throws ValidationError.invalid if email is invalid", () {
      expect(() => EmailAddress("test"), throwsA(ValidationError.invalid));
    });
    test("Should returns an instance if email is valid", () {
      expect(EmailAddress("yann@gmail.com"), isA<EmailAddress>());
      expect(EmailAddress(faker.internet.email()), isA<EmailAddress>());
      expect(EmailAddress(faker.internet.freeEmail()), isA<EmailAddress>());
      expect(EmailAddress(faker.internet.safeEmail()), isA<EmailAddress>());
    });
    test(
        "Should returns true if two emails are equals and false if its are different",
        () {
      final one = EmailAddress("yann@gmail.com");
      final two = EmailAddress("yann@gmail.com");
      final three = EmailAddress(faker.internet.email());
      expect(one == two, true);
      expect(one == three, false);
    });
  });
}
