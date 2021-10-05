import 'package:dartz/dartz.dart';
import 'package:vitrine/domain/error/domain_error.dart';

abstract class Logout {
  Future<Either<DomainError, Unit>> logout();
}
