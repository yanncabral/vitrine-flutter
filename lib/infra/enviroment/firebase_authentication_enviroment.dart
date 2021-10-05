import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:vitrine/data/enviroment/authentication/authentication_enviroment.dart';

class FirebaseAuthenticationEnviroment implements AuthenticationEnviroment {
  @override
  Stream<AuthenticationState> get authenticationState =>
      FirebaseAuth.instance.authStateChanges().map((user) {
        if (user == null) {
          return AuthenticationState.loggedOut;
        } else {
          return AuthenticationState.loggedIn;
        }
      }).distinct();
}
