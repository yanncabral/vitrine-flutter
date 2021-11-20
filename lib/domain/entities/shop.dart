import 'package:vitrine/domain/entities/media.dart';

class Shop {
  final String id;
  final String name;
  final String overview;
  final String url;
  final Media media;

  Shop({
    required this.id,
    required this.name,
    required this.overview,
    required this.url,
    required this.media,
  });
}
