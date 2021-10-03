import 'package:dartz/dartz.dart';
import 'package:vitrine/domain/error/domain_error.dart';
import 'package:vitrine/domain/value_objects/email_address.dart';
import 'package:vitrine/domain/value_objects/password.dart';

abstract class LoginWithEmailAndPasswordUsecase {
  Either<DomainError, void> loginWith(
      {required EmailAddress email, required Password password});
}
