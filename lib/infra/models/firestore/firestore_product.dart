import 'package:vitrine/domain/entities/product.dart';

extension FirestoreProduct on Product {
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "description": description,
      "price": price,
    };
  }

  static Product fromJson(Map json) {
    return Product(
      name: json["name"] as String,
      description: json["description"] as String,
      price: json["price"] as double,
    );
  }
}
