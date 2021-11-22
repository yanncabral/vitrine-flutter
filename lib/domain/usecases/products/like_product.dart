import 'package:dartz/dartz.dart';
import 'package:vitrine/domain/entities/product.dart';
import 'package:vitrine/domain/entities/user.dart';
import 'package:vitrine/domain/error/domain_error.dart';

abstract class LikeProductUsecase {
  Future<Either<DomainError, void>> like({
    required Product product,
    required User user,
  });
}
