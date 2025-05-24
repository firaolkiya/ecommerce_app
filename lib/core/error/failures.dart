import 'package:dartz/dartz.dart';

abstract class Failure {
  final String message;
  final String? code;

  Failure({required this.message, this.code});
}

class ServerFailure extends Failure {
  ServerFailure({String? message, String? code})
      : super(
          message: message ?? 'Server error occurred',
          code: code,
        );
}

class CacheFailure extends Failure {
  CacheFailure({String? message, String? code})
      : super(
          message: message ?? 'Cache error occurred',
          code: code,
        );
}

class NetworkFailure extends Failure {
  NetworkFailure({String? message, String? code})
      : super(
          message: message ?? 'Network error occurred',
          code: code,
        );
}

class ValidationFailure extends Failure {
  ValidationFailure({required String message, String? code})
      : super(
          message: message,
          code: code,
        );
}

// Type alias for Either<Failure, T>
typedef Result<T> = Either<Failure, T>; 