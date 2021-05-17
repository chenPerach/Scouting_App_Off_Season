import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:scouting_app_2/models/PrimoUser.dart';
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
        PrimoUser u =await FirebaseAuthService.instance
            .signInWithEmailAndPassword(event.email, event.password);
        yield Authenticated(u);
      } on AuthException catch(e) {
        print("handling login exception");
        e.happendOn = "LOGIN";
        yield AuthError(e);
      }
    }
    if (event is AuthReset)
      yield AuthenticationInitial();
    if(event is AuthRegister){
      yield AuthLoading();
      try {
        PrimoUser u = await FirebaseAuthService.instance.createUserWithEmailAndPassword(event.email, event.password,name: event.name);
        yield Authenticated(u);
      } on AuthException catch(e) {
        e.happendOn = "REGISTER";
        yield AuthError(e);
      }
    }
    if(event is AuthForgotPassword){
      FirebaseAuthService.instance.sendPasswordResetEmail(event.email);

    }
  }
}
