import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/error/failures.dart';
import 'package:ecommerce/domain/entities/product.dart';
import 'package:ecommerce/domain/repositories/product_repository.dart';

class GetProductById {
  final ProductRepository repository;

  GetProductById(this.repository);

  Future<Either<Failure, ProductEntity>> call(int id) async {
    if (id <= 0) {
      return Left(ValidationFailure(message: 'Invalid product ID'));
    }
    return await repository.getProductById(id);
  }
} 