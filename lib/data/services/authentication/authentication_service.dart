import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vitrine/domain/error/domain_error.dart';
import 'package:vitrine/domain/usecases/login_with_email_and_password_usecase.dart';
import 'package:vitrine/domain/usecases/logout_usecase.dart';
import 'package:vitrine/domain/usecases/register_with_email_and_password_usecase.dart';
import 'package:vitrine/domain/value_objects/email_address.dart';
import 'package:vitrine/domain/value_objects/password.dart';
import 'package:vitrine/domain/value_objects/person_name.dart';
import 'package:vitrine/infra/firebase_errors.dart';

class AuthenticationService
    implements
        LoginWithEmailAndPasswordUsecase,
        RegisterWithEmailAndPassword,
        Logout {
  @override
  Future<Either<DomainError, Unit>> loginWith({
    required EmailAddress email,
    required Password password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email(),
        password: password(),
      );
      return const Right(unit);
    } on FirebaseAuthException catch (e) {
      return Left(e.toDomain());
    }
  }

  @override
  Future<Either<DomainError, Unit>> registerWith({
    required PersonName name,
    required EmailAddress email,
    required Password password,
  }) async {
    try {
      final credentials =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email(),
        password: password(),
      );
      credentials.user?.updateDisplayName(name());
      return const Right(unit);
    } on FirebaseAuthException catch (e) {
      return Left(e.toDomain());
    }
  }

  @override
  Future<Either<DomainError, Unit>> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      return const Right(unit);
    } on FirebaseAuthException catch (e) {
      return Left(e.toDomain());
    }
  }
}
