import 'package:test/test.dart';
import 'package:vitrine/domain/validation/validation_error.dart';
import 'package:vitrine/domain/value_objects/person_name.dart';

void main() {
  group("PersonName value object", () {
    test("Should throw ValidationError if name is too short", () {
      expect(() => PersonName("Y"), throwsA(ValidationError.tooShort));
    });
    test("Should throw ValidationError.isEmpty if name is empty", () {
      expect(() => PersonName(""), throwsA(ValidationError.empty));
    });
    test("Should doesn't throw any error if name is valid", () {
      expect(PersonName("Yann"), isA<PersonName>());
    });
    test("Should returns false if two valid names are different", () {
      expect(PersonName("Yann") == PersonName("Anry"), false);
    });
    test("Should returns true if two valid names are identical", () {
      expect(PersonName("Yann") == PersonName("Yann"), true);
    });
  });
}
