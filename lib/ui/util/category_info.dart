import 'package:vitrine/domain/entities/category.dart';

extension CategoryInfo on Category {
  String get title {
    switch (this) {
      case Category.accessories:
        return "Acessórios";
      case Category.clothes:
        return "Roupas";
      case Category.shoes:
        return "Sapatos";
      case Category.cosmetics:
        return "Cosméticos";
      case Category.toys:
        return "Brinquedos";
    }
  }

  String get imagePath {
    switch (this) {
      case Category.accessories:
        return "assets/categories/accessories.png";
      case Category.clothes:
        return "assets/categories/clothes.png";
      case Category.shoes:
        return "assets/categories/shoes.png";
      case Category.cosmetics:
        return "assets/categories/cosmetics.png";
      case Category.toys:
        return "assets/categories/toys.jpg";
    }
  }
}
