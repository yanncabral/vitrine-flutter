// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dartz/dartz.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// import 'package:vitrine/domain/entities/product.dart';
// import 'package:vitrine/domain/error/domain_error.dart';
// import 'package:vitrine/domain/usecases/products/add_product.dart';
// import 'package:vitrine/infra/models/firestore/firestore_product.dart';

// class UserService implements AddProduct {
//   @override
//   Future<Either<DomainError, Unit>> addProduct(Product product) async {
//     try {
//       final document = FirebaseFirestore.instance.collection("products").doc();
//       final userId = FirebaseAuth.instance.currentUser?.uid;
//       final productInProfile = FirebaseFirestore.instance
//           .collection("profiles")
//           .doc(userId)
//           .collection("products")
//           .doc(document.id);
//       await document.set(product.toJson());
//       final json = product.toJson();
//       if (userId != null) {
//         Future.wait([
//           document.set(json),
//           productInProfile.set(json),
//         ]);
//       }

//       return const Right(unit);
//     } catch (e) {
//       return const Left(DomainError.unexpected);
//     }
//   }
// }
