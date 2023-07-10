import 'package:fashion_app/config/routes/route_context.dart';
import 'package:fashion_app/core/functions/state_renderer.dart';
import 'package:fashion_app/core/utils/values.dart';
import 'package:fashion_app/view/widgets/common/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:fashion_app/controllers/auth/auth_cubit.dart';

import 'package:fashion_app/core/utils/utils.dart';
import 'package:fashion_app/view/auth/widgets/custom_input_field.dart';
import 'package:fashion_app/view/widgets/common/custom_elevated_button.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const TextUtils(text: AppStrings.resetPassword),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              context.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColor.orange,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AssetsIconPath.appIcon),
            const SizedBox(height: AppSizes.s20),
            CustomInputField(
              icon: AssetsIconPath.email,
              hint: AppStrings.email,
              filedType: FieldType.email,
              controller: BlocProvider.of<AuthCubit>(context).emailController,
            ),
            const SizedBox(height: AppSizes.s20),
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                if (state is AuthLoading) {
                  return loadingCircularWidget();
                }
                return CustomElevatedButton(
                  label: AppStrings.send,
                  press: () {
                    BlocProvider.of<AuthCubit>(context).resetPassword(context);
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
