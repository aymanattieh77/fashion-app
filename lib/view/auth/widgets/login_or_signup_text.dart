import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fashion_app/controllers/auth/auth_cubit.dart';
import 'package:fashion_app/core/utils/utils.dart';
import 'package:fashion_app/view/widgets/common/text_utils.dart';

class LoginOrSignUpText extends StatelessWidget {
  const LoginOrSignUpText({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextUtils(
              text: BlocProvider.of<AuthCubit>(context).isLogin
                  ? AppStrings.dontHaveAccount
                  : AppStrings.alreadyHaveAccount,
              fontSize: 14,
              color: AppColor.orange,
            ),
            InkWell(
              onTap: () {
                BlocProvider.of<AuthCubit>(context).switchAuth();
              },
              child: TextUtils(
                text: BlocProvider.of<AuthCubit>(context).isLogin
                    ? AppStrings.signup
                    : AppStrings.login,
                fontSize: 14,
                decoration: TextDecoration.underline,
                color: AppColor.orange,
              ),
            ),
          ],
        );
      },
    );
  }
}
