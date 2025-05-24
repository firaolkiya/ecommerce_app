import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/error/failures.dart';
import 'package:ecommerce/domain/entities/cart.dart';
import 'package:ecommerce/domain/repositories/cart_repository.dart';

class RemoveFromCart {
  final CartRepository repository;

  RemoveFromCart(this.repository);

  Future<Either<Failure, Cart>> call(int userId, int productId) async {
    if (userId <= 0) {
      return Left(ValidationFailure(message: 'Invalid user ID'));
    }
    if (productId <= 0) {
      return Left(ValidationFailure(message: 'Invalid product ID'));
    }
    return await repository.removeFromCart(userId, productId);
  }
} 