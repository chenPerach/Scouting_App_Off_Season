part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {}

class AuthRegister extends AuthenticationEvent{
  final String name,email,password;
  AuthRegister({
    @required this.name,
    @required this.email,
    @required this.password
  });
}
class AuthLogin extends AuthenticationEvent{
  final String email,password;
  AuthLogin({
    @required this.email,
    @required this.password
  });
}

class AuthForgotPassword extends AuthenticationEvent{
  final String email;
  AuthForgotPassword({
    @required this.email,
  });
}
