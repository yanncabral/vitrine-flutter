import 'package:vitrine/domain/entities/product.dart';

extension FirestoreProduct on Product {
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "description": description,
      "price": price,
      "images": images,
      "ownerId": ownerId,
    };
  }

  static Product fromJson(Map json) {
    return Product(
      name: json["name"] as String,
      description: json["description"] as String,
      price: json["price"] as double,
      images: (json["images"] as List).map((e) => e as String).toList(),
      ownerId: (json["ownerId"] ?? "") as String,
    );
  }
}
