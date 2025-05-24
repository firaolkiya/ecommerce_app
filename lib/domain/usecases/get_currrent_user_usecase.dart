import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/error/failures.dart';
import 'package:ecommerce/domain/entities/user.dart';
import 'package:ecommerce/domain/repositories/auth_repository.dart';

class GetCurrentUserUsecase {
  final AuthRepository authRepository;

  GetCurrentUserUsecase({required this.authRepository});
  
    Future<Either<Failure,User>>call(){
      return authRepository.getCurrentUser();
    }

  
}