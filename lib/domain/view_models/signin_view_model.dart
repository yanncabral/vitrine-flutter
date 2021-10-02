import 'package:dartz/dartz.dart';
import 'package:vitrine/domain/validation/validation_error.dart';
import 'package:vitrine/domain/value_objects/email_address.dart';
import 'package:vitrine/domain/value_objects/password.dart';

abstract class SignInViewModel {
  Stream<Either<ValidationError, EmailAddress>?> get emailState;
  Stream<Either<ValidationError, Password>?> get passwordState;
  Stream<bool> get isLoadingState;
  Stream<bool> get isFormValidState;

  void onEmailChange(String value);
  void onPasswordChange(String value);
  void submit();
}
