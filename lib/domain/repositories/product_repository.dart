import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/error/failures.dart';
import 'package:ecommerce/domain/entities/cart.dart';
import 'package:ecommerce/domain/entities/product.dart';

abstract class ProductRepository {
  // Product operations
  Future<Either<Failure, List<ProductEntity>>> getAllProducts();
  Future<Either<Failure, ProductEntity>> getProductById(int id);
  Future<Either<Failure, List<ProductEntity>>> getProductsByCategory(String category);

  // Cart operations
 
}                                                                                                                                                                                                                                                                                 