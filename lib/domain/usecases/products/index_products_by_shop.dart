import 'package:dartz/dartz.dart';
import 'package:vitrine/domain/entities/product.dart';
import 'package:vitrine/domain/entities/shop.dart';
import 'package:vitrine/domain/error/domain_error.dart';

abstract class IndexProductsByShopUsecase {
  Future<Either<DomainError, List<Product>>> find(Shop by, int page);
}
