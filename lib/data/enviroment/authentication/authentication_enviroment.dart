import 'dart:async';

enum AuthenticationState {
  loggedIn,
  loggedOut,
}

abstract class AuthenticationEnviroment {
  Stream<AuthenticationState> get authenticationState;
}
