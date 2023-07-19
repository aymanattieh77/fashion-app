import 'package:fashion_app/domain/usecases/auth/login_usecase.dart';
import 'package:fashion_app/domain/usecases/auth/reset_password_usecase.dart';
import 'package:fashion_app/domain/usecases/auth/sign_out_usecase.dart';
import 'package:fashion_app/domain/usecases/auth/sign_up_usecase.dart';
import 'package:fashion_app/domain/usecases/auth/sign_with_facebook_usecase.dart';
import 'package:fashion_app/domain/usecases/auth/sign_with_google_usecase.dart';
import 'package:fashion_app/domain/usecases/auth/updata_email_usecase.dart';

export 'login_usecase.dart';
export 'sign_out_usecase.dart';
export 'sign_up_usecase.dart';
export 'sign_with_google_usecase.dart';
export 'sign_with_facebook_usecase.dart';
export 'updata_email_usecase.dart';
export 'reset_password_usecase.dart';
export 'reauthenticate_user_usecase.dart';

class AuthUsecases {
  final LoginUsecase loginUsecase;
  final SignInWithFacebook withFacebookUsecase;
  final SignINWithGoogleUsecase withGoogleUsecase;
  final SignoutUsecase signoutUsecase;
  final SignUpUsecase signUpUsecase;
  final UpdateEmailUsecase updateEmailUsecase;
  final ResetPasswordUsecase resetPasswordUsecase;
  AuthUsecases({
    required this.loginUsecase,
    required this.withFacebookUsecase,
    required this.updateEmailUsecase,
    required this.withGoogleUsecase,
    required this.signoutUsecase,
    required this.signUpUsecase,
    required this.resetPasswordUsecase,
  });
}
