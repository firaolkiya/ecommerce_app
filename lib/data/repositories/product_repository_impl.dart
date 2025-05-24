import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/error/failures.dart';
import 'package:ecommerce/data/datasources/local/product_local_datasource.dart';
import 'package:ecommerce/data/datasources/remote/product_remote_data_source.dart';
import 'package:ecommerce/domain/entities/product.dart';
import 'package:ecommerce/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDatasource localDatasource;

  ProductRepositoryImpl({required this.remoteDataSource,required this.localDatasource});

  @override
  Future<Either<Failure, List<ProductEntity>>> getAllProducts() async {
    try {
      final products = await remoteDataSource.getAllProducts();
      return Right(products);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> getProductById(int id) async {
    try {
      if (id <= 0) {
        return Left(ValidationFailure(message: 'Product ID must be greater than 0'));
      }
      final product = await remoteDataSource.getProductById(id);
      return Right(product);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProductsByCategory(String category) async {
    try {
      if (category.isEmpty) {
        return Left(ValidationFailure(message: 'Category cannot be empty'));
      }
      final products = await remoteDataSource.getProductsByCategory(category);
      return Right(products);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  

  
} 