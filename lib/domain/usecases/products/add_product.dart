import 'package:dartz/dartz.dart';
import 'package:vitrine/domain/entities/category.dart';
import 'package:vitrine/domain/entities/media.dart';
import 'package:vitrine/domain/entities/product.dart';
import 'package:vitrine/domain/error/domain_error.dart';

abstract class AddProduct {
  Future<Either<DomainError, Product>> addProduct(
    String title,
    String overview,
    double price,
    List<Media> medias,
    Category category,
    String ownerId,
  );
}
