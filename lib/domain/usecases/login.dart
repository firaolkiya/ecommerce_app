import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/error/failures.dart';
import 'package:ecommerce/domain/entities/user.dart';
import 'package:ecommerce/domain/repositories/auth_repository.dart';

class LoginUsecase {
  final AuthRepository authRepository;

  LoginUsecase({required this.authRepository});
  
    Future<Either<Failure,User>>call(String username,String password){
      return authRepository.login(username,password);
    }

  
}