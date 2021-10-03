import 'package:vitrine/data/authentication/authentication_service.dart';
import 'package:vitrine/domain/usecases/register_with_email_and_password_usecase.dart';

extension RegisterWithEmailAndPasswordFactory on RegisterWithEmailAndPassword {
  static final _authenticationService = AuthenticationService();
  static RegisterWithEmailAndPassword get factory => _authenticationService;
}
