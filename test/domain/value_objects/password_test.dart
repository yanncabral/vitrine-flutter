import 'package:test/test.dart';
import 'package:vitrine/domain/validation/validation_error.dart';
import 'package:vitrine/domain/value_objects/password.dart';

void main() {
  group("Password", () {
    test("Should returns true if two instances have the same value", () {
      final one = Password("12345678");
      final two = Password("12345678");
      final three = Password("123456789");

      expect(one == two, true);
      expect(one == three, false);
    });
  });
}
