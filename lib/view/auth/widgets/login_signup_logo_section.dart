import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:fashion_app/controllers/auth/auth_cubit.dart';
import 'package:fashion_app/core/utils/utils.dart';
import 'package:fashion_app/core/utils/values.dart';
import 'package:fashion_app/view/widgets/common/text_utils.dart';

class LoginSignUpLogoSection extends StatelessWidget {
  const LoginSignUpLogoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: AppSizes.s50,
          width: AppSizes.s50,
          child: SvgPicture.asset(AssetsIconPath.appIcon),
        ),
        const SizedBox(height: AppSizes.s20),
        BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return TextUtils(
              text: BlocProvider.of<AuthCubit>(context).isLogin
                  ? AppStrings.login
                  : AppStrings.signup,
              fontSize: 22,
              fontWe: FontWe.medium,
            );
          },
        ),
      ],
    );
  }
}
