import 'package:vitrine/data/authentication/authentication_service.dart';
import 'package:vitrine/domain/usecases/login_with_email_and_password_usecase.dart';

extension LoginWithEmailAndPasswordUsecaseFactory
    on LoginWithEmailAndPasswordUsecase {
  static final _authenticationService = AuthenticationService();
  static LoginWithEmailAndPasswordUsecase get factory => _authenticationService;
}
