import 'package:dartz/dartz.dart';
import 'package:vitrine/domain/entities/category.dart';
import 'package:vitrine/domain/entities/media.dart';
import 'package:vitrine/domain/entities/product.dart';
import 'package:vitrine/domain/error/domain_error.dart';

abstract class AddProduct {
  Future<Either<DomainError, Product>> addProduct({
    required String title,
    required String overview,
    required double price,
    required List<Media> medias,
    required Category category,
    required String ownerId,
  });
}
