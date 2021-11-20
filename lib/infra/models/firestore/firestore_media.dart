import 'package:vitrine/domain/entities/media.dart';

extension FirestoreMedia on Media {
  Map<String, dynamic> toJson() {
    return {
      "blurHash": blurHash,
      "url": url,
      "altText": altText,
      "mediaType": mediaType.index,
    };
  }

  static Media fromJson(Map json) {
    return Media(
      blurHash: json["blurHash"] as String,
      url: json["url"] as String,
      altText: json["altText"] as String,
      mediaType: MediaType.values[json["mediaType"] as int],
    );
  }
}
