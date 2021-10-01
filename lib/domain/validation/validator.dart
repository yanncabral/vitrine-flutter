import 'package:vitrine/domain/validation/validation_error.dart';

abstract class Validator<T> {
  ValidationError? call(T value);
}
