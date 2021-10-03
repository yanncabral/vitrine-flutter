import 'package:vitrine/domain/view_models/signup_view_model.dart';
import 'package:vitrine/view_model/stream_controller/stream_controller_signup_view_model.dart';

extension SignUpViewModelFactory on SignUpViewModel {
  static final _streamControllerSignUpViewModel =
      StreamControllerSignUpViewModel();
  static SignUpViewModel get factory => _streamControllerSignUpViewModel;
}
