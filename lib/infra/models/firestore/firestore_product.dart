import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vitrine/domain/entities/category.dart';
import 'package:vitrine/domain/entities/product.dart';
import 'package:vitrine/infra/models/firestore/firestore_media.dart';

extension FirestoreProduct on Product {
  Map<String, dynamic> toJson() {
    return {
      "name": title,
      "description": overview,
      "price": price,
      "medias": medias.map((e) => e.toJson()).toList(),
      "owner": ownerId,
    };
  }

  static Product fromJson(Map json, String id) {
    return Product(
      id: id,
      title: json["name"] as String,
      overview: json["description"] as String,
      price: json["price"] as double,
      medias: (json["medias"] as List)
          .map((e) => FirestoreMedia.fromJson(e as Map<String, dynamic>))
          .toList(),
      ownerId: (json["owner"] as DocumentReference).id,
      likes: (json["likes"] as List).map((e) => e as String).toList(),
      category: Category.values[json["category"] as int],
    );
  }
}
