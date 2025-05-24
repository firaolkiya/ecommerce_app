import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/error/failures.dart';
import 'package:ecommerce/data/datasources/local/product_local_datasource.dart';
import 'package:ecommerce/data/datasources/remote/product_remote_data_source.dart';
import 'package:ecommerce/domain/entities/user.dart';
import 'package:ecommerce/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository{
  final ProductLocalDatasource localDatasource;
  final ProductRemoteDataSource remoteDatasource;
  AuthRepositoryImpl({required this.remoteDatasource, required this.localDatasource});
  @override
  Future<Either<Failure, User>> getCurrentUser() async{
    try{
      final user = await localDatasource.getCurrentUser();
      return Right(user);
    }
    catch(e){
      return Left(CacheFailure(message:e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> login(String username, String password) async{
    try{
      final user = await remoteDatasource.login(username,password);
      await localDatasource.saveUser(user);
      return Right(user);
    }
    catch(e){
      return Left(ServerFailure(message:e.toString()));
    }
  }
  
  @override
  Future<void> logout() async{
    await localDatasource.logout();
  }
  
}