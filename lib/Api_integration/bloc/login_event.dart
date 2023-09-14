part of 'login_bloc.dart';

 abstract class UserEvent extends Equatable{
  const UserEvent();
}

class LoginEvent extends UserEvent {
 // const LogInEvent();
  final String username;

  final String password;

   LoginEvent({
    required this.username,
    required this.password,
  });

  @override
  List<Object> get props => [username,password];
  String toString() => 'LoginEvent { username: $username, password: $password }';
}


class InitLogin extends UserEvent {
  String toString() => 'InitLogin';

  @override

  List<Object> get props => [];

}

