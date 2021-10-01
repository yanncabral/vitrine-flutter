import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:vitrine/domain/validation/validation_error.dart';
import 'package:vitrine/domain/value_objects/email_address.dart';
import 'package:vitrine/domain/value_objects/password.dart';
import 'package:vitrine/domain/value_objects/person_name.dart';
import 'package:vitrine/domain/view_models/signup_view_model.dart';

class _SignUpState {
  Either<ValidationError, PersonName>? nameState;
  Either<ValidationError, EmailAddress>? emailState;
  Either<ValidationError, Password>? passwordState;
  bool isLoading = false;
  bool get isFormValid => [
        nameState,
        emailState,
        passwordState,
      ].every((element) => element?.isRight() ?? false);
}

class StreamControllerSignUpViewModel implements SignUpViewModel {
  final _stateController = StreamController<_SignUpState>.broadcast();

  @override
  Stream<Either<ValidationError, PersonName>?> get nameState =>
      _stateController.stream.map((state) => state.nameState).distinct();
  @override
  Stream<Either<ValidationError, EmailAddress>?> get emailState =>
      _stateController.stream.map((state) => state.emailState).distinct();
  @override
  Stream<Either<ValidationError, Password>?> get passwordState =>
      _stateController.stream.map((state) => state.passwordState).distinct();
  @override
  Stream<bool> get isLoadingState =>
      _stateController.stream.map((state) => state.isLoading).distinct();
  @override
  Stream<bool> get isFormValidState =>
      _stateController.stream.map((state) => state.isFormValid).distinct();

  void _setState(void Function() body) {
    body();
    _stateController.add(_state);
  }

  @override
  void onNameChange(String value) {
    _setState(() {
      try {
        _state.nameState = Right(PersonName(value));
      } on ValidationError catch (validationError) {
        _state.nameState = Left(validationError);
      }
    });
  }

  @override
  void onEmailChange(String value) {
    _setState(() {
      try {
        _state.emailState = Right(EmailAddress(value));
      } on ValidationError catch (validationError) {
        _state.emailState = Left(validationError);
      }
    });
  }

  @override
  void onPasswordChange(String value) {
    _setState(() {
      try {
        _state.passwordState = Right(Password(value));
      } on ValidationError catch (validationError) {
        _state.passwordState = Left(validationError);
      }
    });
  }

  @override
  void submit() {
    _setState(() {
      _state.isLoading = true;
    });
  }

  final _SignUpState _state = _SignUpState();
}
