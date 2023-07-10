import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fashion_app/config/routes/route_context.dart';
import 'package:fashion_app/controllers/auth/auth_cubit.dart';
import 'package:fashion_app/core/utils/colors.dart';
import 'package:fashion_app/core/utils/strings.dart';
import 'package:fashion_app/view/widgets/common/text_utils.dart';

import '../forget_password_screen.dart';

class CheckAndAcceptSection extends StatelessWidget {
  const CheckAndAcceptSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AuthCubit>(context);
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (!cubit.isLogin) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Checkbox(
                value: cubit.isChecked,
                onChanged: (value) {
                  cubit.changeChecked(value!);
                },
                activeColor: AppColor.orange,
              ),
              Row(
                children: [
                  TextUtils(
                      text: AppStrings.iAcceptAllThe,
                      fontSize: 12,
                      color: Theme.of(context).primaryColorLight),
                  TextUtils(
                    text: AppStrings.termsConditions,
                    fontSize: 12,
                    color: Theme.of(context).primaryColorLight,
                    fontWe: FontWe.semiBold,
                  ),
                ],
              ),
            ],
          );
        } else {
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  context.goTo(
                    BlocProvider.value(
                      value: cubit,
                      child: const ForgetPasswordScreen(),
                    ),
                  );
                },
                child: const TextUtils(
                  text: AppStrings.forgetPassword,
                  fontSize: 12,
                  color: AppColor.orange,
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
