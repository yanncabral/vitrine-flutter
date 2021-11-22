import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:vitrine/domain/entities/category.dart';
import 'package:vitrine/domain/entities/product.dart';
import 'package:vitrine/domain/error/domain_error.dart';
import 'package:vitrine/domain/usecases/products/index_products.dart';
import 'package:vitrine/domain/usecases/products/index_products_by_category.dart';
import 'package:vitrine/infra/models/firestore/firestore_product.dart';

class FirestoreProductsDatasource
    implements IndexProductsByCategoryUsecase, IndexProductsUsecase {
  static final _remote = FirebaseFirestore.instance.collection("products");

  @override
  Future<Either<DomainError, Iterable<Product>>> findBy({
    required Category category,
    required int page,
  }) async {
    //TODO: handle pagination
    final snapshot = await _remote
        .where(
          "category",
          isEqualTo: category.index,
        )
        .get();

    final products = snapshot.docs.map(
      (e) => FirestoreProduct.fromJson(e.data()),
    );

    return Right(products);
  }

  @override
  Future<Either<DomainError, Iterable<Product>>> index(
      {required int page}) async {
    final snapshot = await _remote
        .withConverter<Product>(
          fromFirestore: (snapshots, _) =>
              FirestoreProduct.fromJson(snapshots.data()!),
          toFirestore: (product, _) => product.toJson(),
        )
        .get();

    final products = snapshot.docs.map((e) => e.data());
    return Right(products);
  }
}
