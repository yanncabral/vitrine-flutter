import 'package:vitrine/domain/entities/product.dart';
import 'package:vitrine/domain/value_objects/person_name.dart';

class Profile {
  final PersonName name;
  final String description;
  final String imageUrl;
  final List<Product> products;

  Profile({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.products,
  });
}
