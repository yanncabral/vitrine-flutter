import 'package:dartz/dartz.dart';
import 'package:vitrine/domain/entities/category.dart';
import 'package:vitrine/domain/entities/product.dart';
import 'package:vitrine/domain/error/domain_error.dart';

abstract class IndexProductsByCategoryUsecase {
  Future<Either<DomainError, List<Product>>> find(Category by, int page);
}
