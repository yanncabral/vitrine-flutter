import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vitrine/domain/error/domain_error.dart';
import 'package:vitrine/domain/usecases/login_with_email_and_password_usecase.dart';
import 'package:vitrine/domain/value_objects/email_address.dart';
import 'package:vitrine/domain/value_objects/password.dart';

class AuthenticationService implements LoginWithEmailAndPasswordUsecase {
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
    } on FirebaseAuthException catch (_) {
      return const Left(DomainError.unexpected);
    }
  }
}
