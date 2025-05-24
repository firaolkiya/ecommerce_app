import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/error/failures.dart';
import 'package:ecommerce/domain/entities/cart.dart';
import 'package:ecommerce/domain/repositories/cart_repository.dart';

class ClearCart {
  final CartRepository repository;

  ClearCart(this.repository);

  Future<Either<Failure, Cart>> call(int userId) async {
    if (userId <= 0) {
      return Left(ValidationFailure(message: 'Invalid user ID'));
    }
    return await repository.clearCart(userId);
  }
} 