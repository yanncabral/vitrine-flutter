import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:vitrine/data/enviroment/authentication/authentication_enviroment.dart';

class _AuthenticationEnviromentState {
  AuthenticationState authenticationState = AuthenticationState.loggedOut;
}

class FirebaseAuthenticationEnviroment implements AuthenticationEnviroment {
  final _state = _AuthenticationEnviromentState();
  final _stateController =
      StreamController<_AuthenticationEnviromentState>.broadcast();

  @override
  Stream<AuthenticationState> get authenticationState => _stateController.stream
      .map((state) => state.authenticationState)
      .distinct();

  void setState(void Function() action) {
    action();
    _stateController.add(_state);
  }

  FirebaseAuthenticationEnviroment() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        _state.authenticationState = AuthenticationState.loggedOut;
      } else {
        _state.authenticationState = AuthenticationState.loggedIn;
      }
    });
  }
}
