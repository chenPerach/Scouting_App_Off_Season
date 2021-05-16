import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:scouting_app_2/services/auth_service.dart';
import 'package:scouting_app_2/services/firebase_auth_service.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial());

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthLogin) {
      yield AuthLoading();
      try {
        User u = await FirebaseAuthService.instance
            .signInWithEmailAndPassword(event.email, event.password);
        yield Authenticated(u);
      } on AuthExeption catch (e) {
        yield AuthError(e);
      }
    }

    if(event is AuthRegister){
      yield AuthLoading();
      try {
        User u = await FirebaseAuthService.instance.createUserWithEmailAndPassword(event.email, event.password,name: event.name);
        yield Authenticated(u);
      } on AuthExeption catch(e) {
        yield AuthError(e);
      }
    }
  }
}
