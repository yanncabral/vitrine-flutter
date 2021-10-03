import 'package:vitrine/domain/value_objects/email_address.dart';
import 'package:vitrine/domain/value_objects/password.dart';

abstract class LoginWithEmailAndPasswordUsecase {
  void loginWith({required EmailAddress email, required Password password});
}
