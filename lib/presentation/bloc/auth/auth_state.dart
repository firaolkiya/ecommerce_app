part of 'auth_bloc.dart';

 class AuthState extends Equatable {
  final User? currentUser;
  final bool isLoggedIn;
  final bool isLoading;
  final String? error;
  const AuthState({
    this.currentUser,
    this.isLoggedIn=false,
    this.isLoading=false,
    this.error
  });
  
  @override
  List<Object?> get props => [currentUser,isLoading,isLoggedIn,error];

  AuthState copyWith(
    { User? currentUser,
   bool? isLoggedIn,
   bool? isLoading,
   String? error,
   }
  ){
    return AuthState(
      currentUser:currentUser,
      isLoggedIn:isLoggedIn??false,
      isLoading:isLoading??false,
      error:error
    );
  }
}




