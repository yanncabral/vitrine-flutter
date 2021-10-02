import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:vitrine/domain/validation/validation_error.dart';
import 'package:vitrine/domain/value_objects/email_address.dart';
import 'package:vitrine/domain/value_objects/password.dart';
import 'package:vitrine/domain/view_models/signin_view_model.dart';

class _SignInState {
  Either<ValidationError, EmailAddress>? emailState;
  Either<ValidationError, Password>? passwordState;
  bool isLoading = false;
  bool get isFormValid => [
        emailState,
        passwordState,
      ].every((element) => element?.isRight() ?? false);
}

class StreamControllerSignInViewModel implements SignInViewModel {
  final _stateController = StreamController<_SignInState>.broadcast();

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

  final _state = _SignInState();
}
