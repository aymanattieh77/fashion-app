import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fashion_app/config/routes/route_context.dart';
import 'package:fashion_app/config/routes/routes.dart';

import 'package:fashion_app/config/services/prefs.dart';
import 'package:fashion_app/config/services/service_locator.dart';

import 'package:fashion_app/controllers/user/user_cubit.dart';

import 'package:fashion_app/core/utils/utils.dart';

import 'package:fashion_app/domain/entities/account/user.dart';

import 'package:fashion_app/domain/usecases/auth/auth_usecase.dart';
import 'package:fashion_app/domain/usecases/base_usecase.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

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
    if (_formVaildate()) {
      if (!isChecked) {
        showSnackMessage(context, message: AppStrings.pleaseFillTheCheckbox);
        return;
      }
      _loading();
      if (_signUpVaildation()) {
        (await _authUsecases.signUpUsecase.call(_signUpInputs())).fold(
          (failure) {
            _failure(context, failure.message);
          },
          (user) {
            _success(context, user);
          },
        );
      }
    }
  }

  Future<void> login(BuildContext context) async {
    if (_formVaildate()) {
      _loading();
      if (_loginVaildation()) {
        (await _authUsecases.loginUsecase.call(_loginInputs())).fold(
          (faliure) {
            _failure(context, faliure.message);
          },
          (user) {
            _success(context, user);
          },
        );
      }
    }
  }

  Future<void> resetPassword(BuildContext context) async {
    if (emailController.text.isNotEmpty && emailController.text.isValidEmail) {
      _loading();
      (await _authUsecases.resetPasswordUsecase.call(emailController.text))
          .fold(
        (failure) {
          _failure(context, failure.message);
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
    _loading();
    (await _authUsecases.withFacebookUsecase.call(const NoParameters())).fold(
      (failure) {
        _failure(context, failure.message);
      },
      (user) {
        _success(context, user);
      },
    );
  }

  Future<void> signWithGoogle(BuildContext context) async {
    _loading();

    (await _authUsecases.withGoogleUsecase.call(const NoParameters())).fold(
      (failure) {
        _failure(context, failure.message);
      },
      (user) {
        _success(context, user);
      },
    );
  }

  Future<void> signOut(BuildContext context) async {
    _loading();
    (await _authUsecases.signoutUsecase.call(const NoParameters())).fold(
      (failure) {
        _failure(context, failure.message);
      },
      (s) {
        emit(AuthSuccess());
        _prefs.deleteUserUid().then((value) {
          Phoenix.rebirth(context);
        });
      },
    );
  }

  Future<void> updateEmail(BuildContext context, String newEmail) async {
    (await _authUsecases.updateEmailUsecase.call(newEmail)).fold(
      (failure) {
        _failure(context, failure.message);
      },
      (r) {
        emit(AuthSuccess());

        showToastMessage("Email Successfully Changed");
      },
    );
  }

  Future<void> saveUserProfile(BuildContext context) async {
    if (_user != null) {
      final userModel = UserModel(
        uid: _prefs.userUid ?? "",
        username: _user!.displayName ?? usernameController.text,
        email: _user!.email ?? emailController.text,
        profilePhoto: _user!.photoURL ?? AppConstants.profilePicturePlaceholder,
      );

      BlocProvider.of<UserCubit>(context)
          .createUserprofile(userModel, userModel.uid)
          .then(
        (value) async {
          await BlocProvider.of<UserCubit>(context)
              .getUserProfileById(userModel.uid);
        },
      );
    }
  }

  SignUpUsecaseInputs _signUpInputs() {
    return SignUpUsecaseInputs(
      usernameController.text,
      emailController.text,
      passController.text,
    );
  }

  LoginUsecaseInputs _loginInputs() {
    return LoginUsecaseInputs(emailController.text, passController.text);
  }

  bool _formVaildate() {
    return fromKey.currentState!.validate();
  }

  bool _signUpVaildation() {
    return usernameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passController.text.isNotEmpty &&
        isChecked;
  }

  bool _loginVaildation() {
    return emailController.text.isNotEmpty && passController.text.isNotEmpty;
  }

  void _loading() {
    emit(AuthLoading());
  }

  void _failure(BuildContext context, String message) {
    emit(AuthFailure(message));
    dismissDialog(context);
    showSnackMessage(context, message: message);
    return;
  }

  void _success(BuildContext context, User user) async {
    await _prefs.saveUserUid(user.uid);
    _user = user;
    // ignore: use_build_context_synchronously
    await saveUserProfile(context);
    emit(AuthSuccess());
    // ignore: use_build_context_synchronously
    context.goToNamed(route: Routes.home, replacement: true);
  }

  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passController.dispose();
  }
}
