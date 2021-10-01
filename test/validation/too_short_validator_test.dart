import 'package:test/test.dart';
import 'package:vitrine/domain/validation/validation_error.dart';
import 'package:vitrine/validation/too_short_validator.dart';

void main() {
  group("TooShortValidator", () {
    final sut = TooShortValidator(minimumLenght: 2);
    test("Should returns null if string is longer than the minimum lenght", () {
      expect(sut("yann"), null);
    });
    test("Should returns null if string is equals to the minimum lenght", () {
      expect(sut("ya"), null);
    });
    test(
        "Should returns tooShort error if string is shorter than the minimum lenght",
        () {
      expect(sut("y"), ValidationError.tooShort);
    });
    test("Should throws a RangeError exception if minimun lenght is negative",
        () {
      expect(() => TooShortValidator(minimumLenght: -2),
          throwsA(isA<RangeError>()));
    });
  });
}
