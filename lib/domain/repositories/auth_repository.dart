import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/error/failures.dart';
import 'package:ecommerce/domain/entities/user.dart';

abstract class AuthRepository{
  Future<Either<Failure,User>>getCurrentUser();
  Future<Either<Failure,User>>login(String username,String password);
  Future<void>logout();
  
}