import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/error/failures.dart';
import 'package:ecommerce/data/datasources/local/product_local_datasource.dart';
import 'package:ecommerce/data/datasources/remote/product_remote_data_source.dart';
import 'package:ecommerce/data/models/cart_model.dart';
import 'package:ecommerce/domain/entities/cart.dart';
import 'package:ecommerce/domain/entities/product.dart';
import 'package:ecommerce/domain/repositories/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDatasource localDatasource;

  CartRepositoryImpl({required this.localDatasource, required this.remoteDataSource});

  

  @override
  Future<Either<Failure, Cart>> getCart(int userId) async {
    try {
      if (userId <= 0) {
        return Left(ValidationFailure(message: 'User ID must be greater than 0'));
      }
      final cart = await remoteDataSource.getCart(userId);
      await localDatasource.storeCart(cart);
      return Right(cart);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Cart>> addToCart(int userId, ProductEntity product) async {
    try {
      if (userId <= 0) {
        return Left(ValidationFailure(message: 'User ID must be greater than 0'));
      }
      if (product.id <= 0) {
        return Left(ValidationFailure(message: 'Product ID must be greater than 0'));
      }
       CartModel? recentCart = await remoteDataSource.getCart(userId);
      final cart = await remoteDataSource.addToCart(recentCart, product);
      return Right(cart);
    } catch (e) {
      print(e.toString());
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Cart>> removeFromCart(int userId, int productId) async {
    try {
      if (userId <= 0) {
        return Left(ValidationFailure(message: 'User ID must be greater than 0'));
      }
      if (productId <= 0) {
        return Left(ValidationFailure(message: 'Product ID must be greater than 0'));
      }
      CartModel? recentCart = await remoteDataSource.getCart(userId);
      final cart = await remoteDataSource.removeFromCart(userId, productId,recentCart);
      print(cart.items.length);
      return Right(cart);
    } catch (e) {
      print(e.toString());
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Cart>> clearCart(int userId) async {
    try {
      if (userId <= 0) {
        return Left(ValidationFailure(message: 'User ID must be greater than 0'));
      }
      final cart = await remoteDataSource.clearCart(userId);
      return Right(cart);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  
} 