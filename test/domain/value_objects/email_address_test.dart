import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:vitrine/domain/value_objects/email_address.dart';
import 'package:vitrine/validation/email_validator.dart';

class EmailValidatorMock extends Mock implements EmailValidator {}

void main() {
  final faker = Faker();
  group("EmailAddress", () {
    test("Should call first validator", () {
      // arrange
      final emailValidator = EmailValidatorMock();
      final fakeEmail = faker.internet.email();
      when(() => emailValidator.call(any())).thenReturn(null);

      // act
      final result = EmailAddress(
        fakeEmail,
        validators: [emailValidator],
      );
      // assert
      expect(result, isA<EmailAddress>());
      verify(() => emailValidator.call(fakeEmail)).called(1);
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
