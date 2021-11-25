import 'package:vitrine/domain/entities/shop.dart';
import 'package:vitrine/infra/models/firestore/firestore_media.dart';

extension FirestoreShop on Shop {
  Map<String, dynamic> toJson() {
    return {
      "title": name,
      "description": overview,
      "url": url,
      "media": media.toJson(),
    };
  }

  static Shop fromJson(Map json, String id) {
    return Shop(
      id: id,
      name: json["title"] as String,
      overview: json["description"] as String,
      url: json["url"] as String,
      media: FirestoreMedia.fromJson(json["media"] as Map<String, dynamic>),
    );
  }
}
