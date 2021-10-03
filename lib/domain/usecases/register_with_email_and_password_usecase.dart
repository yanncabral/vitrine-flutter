import 'package:dartz/dartz.dart';
import 'package:vitrine/domain/error/domain_error.dart';
import 'package:vitrine/domain/value_objects/email_address.dart';
import 'package:vitrine/domain/value_objects/password.dart';
import 'package:vitrine/domain/value_objects/person_name.dart';

abstract class RegisterWithEmailAndPassword {
  Future<Either<DomainError, Unit>> registerWith({
    required PersonName name,
    required EmailAddress email,
    required Password password,
  });
}
