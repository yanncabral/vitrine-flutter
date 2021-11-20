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

  static Product fromJson(Map json) {
    return Product(
      id: "", // TODO: Fix id
      title: json["name"] as String,
      overview: json["description"] as String,
      price: json["price"] as double,
      medias: (json["medias"] as List)
          .map((e) => FirestoreMedia.fromJson(e as Map<String, dynamic>))
          .toList(),
      ownerId: (json["owner"] ?? "dizyann") as String,
      likes: json["likes"] as List<String>,
      category: Category.values[json["category"] as int],
    );
  }
}
