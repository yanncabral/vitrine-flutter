import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:vitrine/domain/entities/product.dart';
import 'package:vitrine/domain/entities/user.dart';
import 'package:vitrine/domain/error/domain_error.dart';

abstract class LikeProductUsecase {
  Future<Either<DomainError, Void>> like(Product product, User user);
}
