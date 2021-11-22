import 'package:dartz/dartz.dart';
import 'package:vitrine/domain/entities/product.dart';
import 'package:vitrine/domain/entities/user.dart';
import 'package:vitrine/domain/error/domain_error.dart';

abstract class IndexLikedProductsUsecase {
  Future<Either<DomainError, List<Product>>> find({User user});
}
