import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vitrine/domain/error/domain_error.dart';
import 'package:vitrine/domain/validation/validation_error.dart';
import 'package:vitrine/domain/value_objects/email_address.dart';
import 'package:vitrine/domain/value_objects/password.dart';
import 'package:vitrine/domain/value_objects/person_name.dart';
import 'package:vitrine/domain/view_models/signup_view_model.dart';
import 'package:vitrine/main/factory/domain/usecases/register_with_email_and_password_factory.dart';

class _SignUpState {
  Either<ValidationError, PersonName>? nameState;
  Either<ValidationError, EmailAddress>? emailState;
  Either<ValidationError, Password>? passwordState;
  DomainError? formError;
  bool isLoading = false;

  String description = "";
  String instagramUser = "";

  bool get isFormValid => [
        nameState,
        emailState,
        passwordState,
      ].every((element) => element?.isRight() ?? false);
}

class StreamControllerSignUpViewModel implements SignUpViewModel {
  final registerWithEmailAndPassword =
      RegisterWithEmailAndPasswordFactory.factory;
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
  Stream<DomainError?> get formError =>
      _stateController.stream.map((state) => state.formError).distinct();

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
      _state.formError = null;
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
    _setState(() {
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
    _setState(() {
      _state.isLoading = true;
    });
    final name = _state.nameState?.fold((l) => null, (r) => r);
    final email = _state.emailState?.fold((l) => null, (r) => r);
    final password = _state.passwordState?.fold((l) => null, (r) => r);
    if (name != null && email != null && password != null) {
      final result = await registerWithEmailAndPassword.registerWith(
        name: name,
        email: email,
        password: password,
      );
      _setState(() {
        _state.isLoading = false;
        result.fold((error) {
          _state.formError = error;
        }, (r) async {
          // TODO: Move it to its own layer
          final user = FirebaseAuth.instance.currentUser;
          if (user != null) {
            await FirebaseFirestore.instance
                .collection("profiles")
                .doc(user.uid)
                .set({
              "name": name(),
              "description": _state.description,
              "instagram": _state.instagramUser,
              "imageUrl": "",
            });
          }
        });
      });
    }
    callback();
  }

  final _SignUpState _state = _SignUpState();

  @override
  Stream<String> get description =>
      _stateController.stream.map((state) => state.description).distinct();

  @override
  Stream<String> get instagramUser =>
      _stateController.stream.map((state) => state.instagramUser).distinct();

  @override
  void onDescriptionChange(String value) {
    _setState(() {
      _state.formError = null;
      _state.description = value;
    });
  }

  @override
  void onInstagramUserChange(String value) {
    _setState(() {
      _state.formError = null;
      _state.instagramUser = value;
    });
  }
}
