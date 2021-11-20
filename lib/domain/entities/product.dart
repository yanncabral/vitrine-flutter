import 'package:vitrine/domain/entities/category.dart';
import 'package:vitrine/domain/entities/media.dart';

class Product {
  final String? id;
  final String title;
  final String overview;
  final double price;
  final List<Media> medias;
  final Category category;
  final String ownerId;
  final List<String> likes;

  Product({
    required this.id,
    required this.title,
    required this.overview,
    required this.price,
    required this.medias,
    required this.category,
    required this.ownerId,
    required this.likes,
  });
}
