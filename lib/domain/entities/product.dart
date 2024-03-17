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

extension ProductSample on Product {
  static Product get sample => Product(
        id: null,
        title: "Kit Psicodelia",
        overview:
            "Dois brincos no formato de cogumelos e um arco com uma mão, Dois brincos no formato de cogumelos e um arco com uma mão, Dois brincos no formato de cogumelos e um arco com uma mão",
        price: 38,
        medias: [
          Media(
            blurHash: "00G8s0",
            url:
                "https://firebasestorage.googleapis.com/v0/b/vitrine-51eda.appspot.com/o/images%2F83340953_267094430939194_4693379384493417560_n.jpg?alt=media&token=a5158443-843b-4a9c-9f6e-7e32d80d86b4",
            altText: "Mulher negra vestindo acessórios de carnaval",
            mediaType: MediaType.photo,
          ),
        ],
        category: Category.accessories,
        ownerId: "TdY2e7r1ncauUs2L5IFfEguvc9s2",
        likes: [],
      );
}
