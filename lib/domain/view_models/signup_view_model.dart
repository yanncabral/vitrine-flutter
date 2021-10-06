import 'package:dartz/dartz.dart';
import 'package:vitrine/domain/error/domain_error.dart';
import 'package:vitrine/domain/validation/validation_error.dart';
import 'package:vitrine/domain/value_objects/email_address.dart';
import 'package:vitrine/domain/value_objects/password.dart';
import 'package:vitrine/domain/value_objects/person_name.dart';

abstract class SignUpViewModel {
  Stream<Either<ValidationError, PersonName>?> get nameState;
  Stream<Either<ValidationError, EmailAddress>?> get emailState;
  Stream<Either<ValidationError, Password>?> get passwordState;
  Stream<String> get description;
  Stream<String> get instagramUser;
  Stream<DomainError?> get formError;
  Stream<bool> get isLoadingState;
  Stream<bool> get isFormValidState;

  void onDescriptionChange(String value);
  void onInstagramUserChange(String value);

  void onNameChange(String value);
  void onEmailChange(String value);
  void onPasswordChange(String value);
  void submit(void Function() calback);
}
