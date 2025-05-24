import 'package:bloc/bloc.dart';
import 'package:ecommerce/domain/entities/user.dart';
import 'package:ecommerce/domain/usecases/get_currrent_user_usecase.dart';
import 'package:ecommerce/domain/usecases/login.dart';
import 'package:ecommerce/domain/usecases/logout_usecase.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GetCurrentUserUsecase getUserUsecase;
  final LoginUsecase loginUsecase;
  final LogoutUsecase logoutUsecase;
  AuthBloc({required this.logoutUsecase, required this.getUserUsecase, required this.loginUsecase}) : super(const AuthState()) {
    on<LoginEvent>(_handleLogin);

    on<LogoutEvent>(_handleLogout);

  }

  Future<void> _handleLogin(LoginEvent event,Emitter<AuthState> emit)async{
    emit(state.copyWith(isLoading:true));
    final response = await loginUsecase.call(event.username,event.password);
    response.fold(
      (left){
        emit(state.copyWith(error:left.message,isLoading: false));
      },
      (user){
        emit(state.copyWith(currentUser:user,isLoggedIn:true));
    });

  }

   Future<void> _handleLogout(LogoutEvent event,Emitter<AuthState> emit)async{
    emit(state.copyWith(isLoading:true));
    await logoutUsecase.call();
    emit(state.copyWith(isLoggedIn:false));
  }
}
