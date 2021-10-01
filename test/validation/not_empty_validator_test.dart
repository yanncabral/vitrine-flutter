import 'package:test/test.dart';
import 'package:vitrine/domain/validation/validation_error.dart';
import 'package:vitrine/validation/not_empty_validator.dart';

void main() {
  group("NotEmptyValidator", () {
    final sut = NotEmptyValidator();
    test("Should returns ValidationError if data is an empty string", () {
      expect(sut(""), ValidationError.empty);
    });
    test("Should returns null if data isn't an empty string", () {
      expect(sut("test string"), null);
    });
  });
}
