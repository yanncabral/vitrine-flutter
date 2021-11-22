import 'package:dartz/dartz.dart';
import 'package:vitrine/domain/entities/product.dart';
import 'package:vitrine/domain/entities/user.dart';
import 'package:vitrine/domain/error/domain_error.dart';

abstract class RemoveLikeProductUsecase {
  Future<Either<DomainError, void>> removeLike({
    required Product product,
    required User user,
  });
}
