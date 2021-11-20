import 'package:dartz/dartz.dart';
import 'package:vitrine/domain/entities/product.dart';
import 'package:vitrine/domain/error/domain_error.dart';

abstract class AddProduct {
  Future<Either<DomainError, Unit>> addProduct(Product product);
}
