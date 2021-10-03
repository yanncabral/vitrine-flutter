import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:vitrine/domain/validation/validation_error.dart';
import 'package:vitrine/domain/validation/validator.dart';

abstract class ValueObject<T> extends Equatable {
  final T _data;

  T call() => _data;

  @override
  List<T> get props => [_data];

  const ValueObject(this._data);
  @protected
  List<Validator> get validators;

  @protected
  ValidationError? get validationError => validators
      .map((validate) => validate(_data))
      .firstWhere((element) => element is ValidationError, orElse: () => null);
}
