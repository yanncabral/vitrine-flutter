import 'package:dartz/dartz.dart';
import 'package:vitrine/domain/entities/category.dart';
import 'package:vitrine/domain/entities/product.dart';
import 'package:vitrine/domain/error/domain_error.dart';

abstract class IndexProductsByCategoryUsecase {
  Future<Either<DomainError, Iterable<Product>>> findBy({
    required Category category,
    required int page,
  });
}
