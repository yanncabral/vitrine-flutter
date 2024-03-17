import 'package:dartz/dartz.dart';
import 'package:vitrine/data/services/firestore/firestore_product_service.dart';
import 'package:vitrine/domain/entities/product.dart';
import 'package:vitrine/domain/error/domain_error.dart';

class ProductsRepository {
  final remoteDatasource = FirestoreProductsDatasource();
  final localDatasource = FirestoreProductsDatasource();

  void index({
    required int page,
    required void Function(Either<DomainError, Iterable<Product>> result)
        callback,
  }) {}
}
