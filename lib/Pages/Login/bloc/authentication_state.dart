part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class AuthLoading extends AuthenticationState {}
class Authenticated extends AuthenticationState {
  final User user;
  Authenticated(this.user);
}

class AuthError extends AuthenticationState {
  final AuthException exception;
  AuthError(this.exception);
}
