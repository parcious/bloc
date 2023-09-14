part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();
  
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}
class LoginLoadingState extends LoginState {}
class LoginSuccessState extends LoginState {
  // final List<LogInModel> loginModel;
  const LoginSuccessState();
    @override
  List<Object> get props => [];
}
class LoginErrorState extends LoginState {

  final String error;

  LoginErrorState(this.error);

}


