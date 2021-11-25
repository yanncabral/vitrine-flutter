import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:vitrine/domain/entities/product.dart';
import 'package:vitrine/domain/entities/shop.dart';
import 'package:vitrine/domain/error/domain_error.dart';
import 'package:vitrine/domain/usecases/shop/find_shop_by_product.dart';
import 'package:vitrine/infra/models/firestore/firestore_shop.dart';

class FirestoreShopService implements FindShopByProduct {
  final _remote = FirebaseFirestore.instance.collection("shops");

  @override
  Future<Either<DomainError, Shop>> findShopByProduct({
    required Product product,
  }) async {
    final snapshot = await _remote
        .doc(product.ownerId)
        .withConverter<Shop>(
          fromFirestore: (snapshot, _) =>
              FirestoreShop.fromJson(snapshot.data()!, snapshot.id),
          toFirestore: (shop, _) => shop.toJson(),
        )
        .get();

    final shop = snapshot.data();

    if (shop == null) {
      return const Left(DomainError.unexpected);
    } else {
      return Right(shop);
    }
  }
}
