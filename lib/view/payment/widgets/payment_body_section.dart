import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:fashion_app/controllers/payment/payment_cubit.dart';
import 'package:fashion_app/core/utils/assets.dart';
import 'package:fashion_app/core/utils/colors.dart';
import 'package:fashion_app/core/utils/strings.dart';
import 'package:fashion_app/core/utils/values.dart';
import 'package:fashion_app/view/widgets/common/custom_elevated_button.dart';

import '../../widgets/common/text_utils.dart';

class PaymentBodySection extends StatelessWidget {
  const PaymentBodySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Container(
            padding: const EdgeInsets.all(60),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColor.orange,
                width: 10,
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(AppPadding.p20),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.orangeLight,
              ),
              child: SvgPicture.asset(AssetsIconPath.check),
            ),
          ),
        ),
        const SizedBox(height: AppSizes.s10),
        const TextUtils(
          text: AppStrings.paymantSuccessfully,
          fontSize: 24,
          fontWe: FontWe.medium,
        ),
        const SizedBox(height: AppSizes.s10),
        TextUtils(
          text: AppStrings.paymentIsTheTransfer,
          fontSize: 14,
          color: Theme.of(context).primaryColorLight,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSizes.s20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 70),
          child: Column(
            children: [
              CustomElevatedButton(
                label: AppStrings.getYourReceipt,
                press: () {
                  //TODO get your receipt
                },
              ),
              const SizedBox(height: AppSizes.s10),
              CustomElevatedButton(
                label: AppStrings.backToHome,
                press: () {
                  BlocProvider.of<PaymentCubit>(context).backToHome(context);
                },
                backgroundColor: AppColor.orangeLight,
                textColor: AppColor.orange,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
