import 'package:faker/faker.dart';
import 'package:test/test.dart';
import 'package:vitrine/domain/validation/validation_error.dart';
import 'package:vitrine/domain/validation/validator.dart';
import 'package:vitrine/domain/value_objects/value_object.dart';
import 'package:vitrine/validation/email_validator.dart';

class EmailAddress extends ValueObject<String> {
  EmailAddress(String data) : super(data) {
    if (validationError != null) {
      throw validationError!;
    }
  }

  @override
  List<Validator> get validators => [EmailValidator()];
}

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
  });
}
