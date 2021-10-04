import 'package:vitrine/data/enviroment/authentication/authentication_enviroment.dart';
import 'package:vitrine/infra/enviroment/firebase_authentication_enviroment.dart';

extension AuthenticationEnviromentFactory on AuthenticationEnviroment {
  static final _instance = FirebaseAuthenticationEnviroment();
  static AuthenticationEnviroment get factory =>
      AuthenticationEnviromentFactory._instance;
}
