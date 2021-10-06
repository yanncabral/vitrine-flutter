import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:vitrine/domain/entities/product.dart';
import 'package:vitrine/domain/error/domain_error.dart';
import 'package:vitrine/domain/usecases/add_product.dart';
import 'package:vitrine/infra/models/firestore/firestore_product.dart';

class UserService implements AddProduct {
  @override
  Future<Either<DomainError, Unit>> addProduct(Product product) async {
    try {
      FirebaseFirestore.instance
          .collection("products")
          .doc()
          .set(product.toJson());
      return const Right(unit);
    } catch (e) {
      return const Left(DomainError.unexpected);
    }
  }
}
