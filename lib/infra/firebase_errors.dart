import 'package:firebase_auth/firebase_auth.dart';
import 'package:vitrine/domain/error/domain_error.dart';

extension FirebaseAuthDomainException on FirebaseAuthException {
  DomainError toDomain() {
    switch (code) {
      case "invalid-email":
        return DomainError.invalidEmail;
      case "user-disabled":
        return DomainError.userDisabled;
      case "user-not-found":
        return DomainError.userNotFound;
      case "wrong-password":
        return DomainError.wrongPassword;
      default:
        return DomainError.unexpected;
    }
  }
}
