import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/error/failures.dart';
import 'package:ecommerce/domain/entities/product.dart';
import 'package:ecommerce/domain/repositories/product_repository.dart';

class GetProductsByCategory {
  final ProductRepository repository;

  GetProductsByCategory(this.repository);

  Future<Either<Failure, List<ProductEntity>>> call(String category) async {
    if (category.isEmpty) {
      return Left(ValidationFailure(message: 'Category cannot be empty'));
    }
    return await repository.getProductsByCategory(category);
  }
} 