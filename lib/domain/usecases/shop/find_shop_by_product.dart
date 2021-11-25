import 'package:dartz/dartz.dart';
import 'package:vitrine/domain/entities/product.dart';
import 'package:vitrine/domain/entities/shop.dart';
import 'package:vitrine/domain/error/domain_error.dart';

abstract class FindShopByProduct {
  Future<Either<DomainError, Shop>> findShopByProduct({
    required Product product,
  });
}
