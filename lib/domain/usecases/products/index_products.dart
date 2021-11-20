import 'package:dartz/dartz.dart';
import 'package:vitrine/domain/entities/product.dart';
import 'package:vitrine/domain/error/domain_error.dart';

abstract class IndexProductsUsecase {
  Future<Either<DomainError, List<Product>>> index();
}
