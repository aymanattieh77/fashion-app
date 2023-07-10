import 'package:fashion_app/core/functions/state_renderer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fashion_app/controllers/auth/auth_cubit.dart';

import 'package:fashion_app/core/extensions/media_query_extension.dart';

import 'package:fashion_app/core/utils/utils.dart';
import 'package:fashion_app/core/utils/values.dart';

import 'package:fashion_app/view/auth/widgets/check_and_accept_section.dart';
import 'package:fashion_app/view/auth/widgets/custom_input_field.dart';
import 'package:fashion_app/view/auth/widgets/login_or_signup_text.dart';
import 'package:fashion_app/view/auth/widgets/or_divider.dart';

import 'package:fashion_app/view/widgets/common/custom_elevated_button.dart';

import 'widgets/google_and_facebook_login.dart';
import 'widgets/login_signup_logo_section.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late AuthCubit cubit;
  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<AuthCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          showFullScreenLoadingState(context);
        }
        if (state is AuthSuccess) {
          cubit.saveUserProfile(context);
        }
        if (state is AuthFailure) {
          return;
        }
      },
      child: _screenContent(context),
    );
  }

  Widget _screenContent(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: context.fullHeight(),
          width: context.fullWidth(),
          padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p20,
            vertical: AppPadding.p20,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: cubit.fromKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const LoginSignUpLogoSection(),
                  const SizedBox(height: AppSizes.s20),
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      if (cubit.isLogin) {
                        return Container();
                      }
                      return CustomInputField(
                        hint: AppStrings.username,
                        icon: AssetsIconPath.profile,
                        filedType: FieldType.text,
                        controller: cubit.usernameController,
                      );
                    },
                  ),
                  CustomInputField(
                    hint: AppStrings.email,
                    icon: AssetsIconPath.email,
                    filedType: FieldType.email,
                    controller: cubit.emailController,
                  ),
                  CustomInputField(
                    hint: AppStrings.password,
                    icon: AssetsIconPath.lock,
                    filedType: FieldType.password,
                    controller: cubit.passController,
                  ),
                  const SizedBox(height: AppSizes.s5),
                  const CheckAndAcceptSection(),
                  const SizedBox(height: AppSizes.s10),
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 80),
                        child: CustomElevatedButton(
                          label: cubit.isLogin
                              ? AppStrings.login
                              : AppStrings.signup,
                          press: cubit.isLogin ? _login : _signUp,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: AppSizes.s15),
                  const OrDivider(),
                  const SizedBox(height: AppSizes.s15),
                  GoogleAndFacebookLogin(
                    facebookLogin: _facebookLogin,
                    googleLogin: _googleLogin,
                  ),
                  const SizedBox(height: AppSizes.s15),
                  const LoginOrSignUpText(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _facebookLogin() async {
    await cubit.signWithFacebook(context);
  }

  void _googleLogin() async {
    await cubit.signWithGoogle(context);
  }

  void _signUp() async {
    await cubit.signUp(context);
  }

  void _login() async {
    await cubit.login(context);
  }

  @override
  void dispose() {
    cubit.dispose();
    super.dispose();
  }
}
