import 'package:vitrine/domain/view_models/signin_view_model.dart';
import 'package:vitrine/view_model/stream_controller/stream_controller_signin_view_model.dart';

extension SignInViewModelFactory on SignInViewModel {
  static final _streamControllerSignInViewModel =
      StreamControllerSignInViewModel();
  static SignInViewModel get factory => _streamControllerSignInViewModel;
}
