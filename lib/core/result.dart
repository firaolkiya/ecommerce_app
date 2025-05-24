import 'package:ecommerce/core/error/failures.dart';

abstract class Result<T> {
  const Result();
}

class Success<T> extends Result<T> {
  final T value;

  const Success(this.value);
}

class Error<T> extends Result<T> {
  final Failure failure;

  const Error(this.failure);
} 