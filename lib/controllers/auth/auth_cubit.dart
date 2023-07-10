import 'package:fashion_app/config/routes/route_context.dart';
import 'package:fashion_app/config/services/prefs.dart';
import 'package:fashion_app/config/services/service_locator.dart';
import 'package:fashion_app/controllers/user/user_cubit.dart';
import 'package:fashion_app/core/utils/constants.dart';
import 'package:fashion_app/core/utils/strings.dart';
import 'package:fashion_app/domain/entities/account/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fashion_app/core/extensions/string_extension.dart';
import 'package:fashion_app/core/functions/function.dart';
import 'package:fashion_app/domain/usecases/auth/auth_usecase.dart';
import 'package:fashion_app/domain/usecases/auth/login_usecase.dart';
import 'package:fashion_app/domain/usecases/auth/sign_up_usecase.dart';
import 'package:fashion_app/domain/usecases/base_usecase.dart';
import 'package:fashion_app/config/routes/routes.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authUsecases) : super(AuthInitial());

  final AuthUsecases _authUsecases;
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final fromKey = GlobalKey<FormState>();
  bool isChecked = false;
  bool isLogin = true;
  final _prefs = getIt<AppPrefs>();
  User? _user;
  void changeChecked(bool value) {
    isChecked = value;
    emit(AuthInitial());
  }

  void switchAuth() {
    isLogin = !isLogin;
    emit(AuthChange());
  }

  Future<void> signUp(BuildContext context) async {
    if (fromKey.currentState!.validate()) {
      if (!isChecked) {
        showSnackMessage(context, message: AppStrings.pleaseFillTheCheckbox);
        return;
      }
      emit(AuthLoading());
      if (usernameController.text.isNotEmpty &&
          emailController.text.isNotEmpty &&
          passController.text.isNotEmpty &&
          isChecked) {
        (await _authUsecases.signUpUsecase.call(SignUpUsecaseInputs(
                usernameController.text,
                emailController.text,
                passController.text)))
            .fold(
          (failure) {
            emit(AuthFailure(failure.message));
            dismissDialog(context);
            showSnackMessage(context, message: failure.message);
            return;
          },
          (user) {
            _prefs.saveUserUid(user.uid);
            _user = user;
            emit(AuthSuccess());

            // ignore: use_build_context_synchronously

            context.goToNamed(route: Routes.home, replacement: true);
          },
        );
      }
    }
  }

  Future<void> login(BuildContext context) async {
    if (fromKey.currentState!.validate()) {
      emit(AuthLoading());
      if (emailController.text.isNotEmpty && passController.text.isNotEmpty) {
        (await _authUsecases.loginUsecase.call(
                LoginUsecaseInputs(emailController.text, passController.text)))
            .fold(
          (faliure) {
            emit(AuthFailure(faliure.message));
            dismissDialog(context);
            showSnackMessage(context, message: faliure.message);
            return;
          },
          (user) {
            _prefs.saveUserUid(user.uid);
            _user = user;
            emit(AuthSuccess());

            context.goToNamed(route: Routes.home, replacement: true);
          },
        );
      }
    }
  }

  Future<void> resetPassword(BuildContext context) async {
    if (emailController.text.isNotEmpty && emailController.text.isValidEmail) {
      emit(AuthLoading());
      (await _authUsecases.resetPasswordUsecase.call(emailController.text))
          .fold(
        (failure) {
          emit(AuthFailure(failure.message));
          dismissDialog(context);
          showSnackMessage(context, message: failure.message);
        },
        (r) {
          emit(AuthSuccess());

          showSnackMessage(context, message: AppStrings.checkYourEmailAddress);
          context.back();
        },
      );
    } else {
      showSnackMessage(context, message: AppStrings.emailInvaild);
    }
  }

  Future<void> signWithFacebook(BuildContext context) async {
    emit(AuthLoading());
    (await _authUsecases.withFacebookUsecase.call(const NoParameters())).fold(
      (failure) {
        emit(AuthFailure(failure.message));
        dismissDialog(context);
        showSnackMessage(context, message: failure.message);

        return;
      },
      (user) {
        _prefs.saveUserUid(user.uid);
        _user = user;
        emit(AuthSuccess());

        context.goToNamed(route: Routes.home, replacement: true);
      },
    );
  }

  Future<void> signWithGoogle(BuildContext context) async {
    emit(AuthLoading());

    (await _authUsecases.withGoogleUsecase.call(const NoParameters())).fold(
      (failure) {
        emit(AuthFailure(failure.message));
        dismissDialog(context);
        showSnackMessage(context, message: failure.message);
        return;
      },
      (user) {
        _prefs.saveUserUid(user.uid);
        _user = user;
        emit(AuthSuccess());

        context.goToNamed(route: Routes.home, replacement: true);
      },
    );
  }

  Future<void> signOut(BuildContext context) async {
    emit(AuthLoading());

    (await _authUsecases.signoutUsecase.call(const NoParameters())).fold(
      (failure) {
        emit(AuthFailure(failure.message));
        showSnackMessage(context, message: failure.message);
        _prefs.deleteUserUid();
      },
      (s) {
        emit(AuthSuccess());
        _prefs.deleteUserUid();
        context.pushRemoveUntil(Routes.auth);
      },
    );
  }

  Future<void> updateEmail(BuildContext context, String newEmail) async {
    (await _authUsecases.updateEmailUsecase.call(newEmail)).fold(
      (failure) {
        emit(AuthFailure(failure.message));
        showSnackMessage(context, message: failure.message);
      },
      (r) {
        emit(AuthSuccess());
        showSnackMessage(context, message: "Email Successfully Changed");
      },
    );
  }

  saveUserProfile(BuildContext context) async {
    if (_user != null) {
      final userModel = UserModel(
        uid: _prefs.userUid,
        username: _user!.displayName ?? usernameController.text,
        email: _user!.email ?? emailController.text,
        profilePhoto: _user!.photoURL ?? AppConstants.profilePicturePlaceholder,
      );

      BlocProvider.of<UserCubit>(context).createUserprofile(userModel).then(
        (value) async {
          await BlocProvider.of<UserCubit>(context).getUserProfileById();
        },
      );
    }
  }

  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passController.dispose();
  }
}
