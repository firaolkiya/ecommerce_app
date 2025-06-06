part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}


final class LoginEvent extends AuthEvent{
  final String username;
  final String password;

  const LoginEvent({
   required this.username,
   required this.password
   });
}

final class LogoutEvent extends AuthEvent{
}