import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/error/failures.dart';
import 'package:ecommerce/domain/entities/cart.dart';
import 'package:ecommerce/domain/entities/product.dart';

abstract class CartRepository {
  Future<Either<Failure, Cart>> getCart(int userId);
  Future<Either<Failure, Cart>> addToCart(int userId, ProductEntity product);
  Future<Either<Failure, Cart>> removeFromCart(int userId, int productId);
  Future<Either<Failure, Cart>> clearCart(int userId);
} 