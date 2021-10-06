import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:vitrine/domain/error/domain_error.dart';
import 'package:vitrine/domain/validation/validation_error.dart';
import 'package:vitrine/domain/value_objects/email_address.dart';
import 'package:vitrine/domain/value_objects/password.dart';
import 'package:vitrine/domain/view_models/signin_view_model.dart';
import 'package:vitrine/main/factory/domain/usecases/login_with_email_and_password_usecase_factory.dart';

class _SignInState {
  Either<ValidationError, EmailAddress>? emailState;
  Either<ValidationError, Password>? passwordState;
  DomainError? formError;
  bool isLoading = false;
  bool get isFormValid => [
        emailState,
        passwordState,
      ].every((element) => element?.isRight() ?? false);
}

class StreamControllerSignInViewModel implements SignInViewModel {
  final loginWithEmailAndPassword =
      LoginWithEmailAndPasswordUsecaseFactory.factory;
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

  @override
  Stream<DomainError?> get formError =>
      _stateController.stream.map((state) => state.formError).distinct();

  @protected
  void setState(void Function() body) {
    body();
    _stateController.add(_state);
  }

  @override
  void onEmailChange(String value) {
    setState(() {
      _state.formError = null;
      try {
        _state.emailState = Right(EmailAddress(value));
      } on ValidationError catch (validationError) {
        _state.emailState = Left(validationError);
      }
    });
  }

  @override
  void onPasswordChange(String value) {
    setState(() {
      _state.formError = null;
      try {
        _state.passwordState = Right(Password(value));
      } on ValidationError catch (validationError) {
        _state.passwordState = Left(validationError);
      }
    });
  }

  @override
  Future<void> submit(void Function() callback) async {
    setState(() {
      _state.isLoading = true;
    });
    final email = _state.emailState?.fold((l) => null, (r) => r);
    final password = _state.passwordState?.fold((l) => null, (r) => r);
    if (email != null && password != null) {
      final result = await loginWithEmailAndPassword.loginWith(
        email: email,
        password: password,
      );
      setState(() {
        _state.isLoading = false;
        result.fold((error) {
          _state.formError = error;
        }, (result) => callback());
      });
    }
  }

  final _state = _SignInState();
}
