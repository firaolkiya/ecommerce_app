import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/error/failures.dart';
import 'package:ecommerce/domain/entities/cart.dart';
import 'package:ecommerce/domain/entities/product.dart';
import 'package:ecommerce/domain/repositories/cart_repository.dart';

class AddToCart {
  final CartRepository repository;

  AddToCart(this.repository);

  Future<Either<Failure, Cart>> call(int userId, ProductEntity product) async {
    if (userId <= 0) {
      return Left(ValidationFailure(message: 'Invalid user ID'));
    }
    if (product.id <= 0) {
      return Left(ValidationFailure(message: 'Invalid product ID'));
    }
    return await repository.addToCart(userId, product);
  }
} 