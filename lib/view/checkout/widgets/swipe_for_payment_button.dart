import 'package:fashion_app/controllers/payment/payment_cubit.dart';

import 'package:fashion_app/core/utils/colors.dart';
import 'package:fashion_app/core/utils/strings.dart';
import 'package:fashion_app/core/utils/values.dart';
import 'package:fashion_app/view/widgets/common/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SwipeForPaymentButton extends StatelessWidget {
  const SwipeForPaymentButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20 + 30),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.orange,
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50))),
        onPressed: () {
          BlocProvider.of<PaymentCubit>(context)
              .makePayment(amount: '2000', currency: 'USD');

          //todo replacement
        },
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppPadding.p5),
              decoration: const BoxDecoration(
                color: AppColor.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_forward,
                color: AppColor.orange,
              ),
            ),
            const SizedBox(width: AppSizes.s20),
            const TextUtils(
                text: AppStrings.swipeForPayment, color: AppColor.white),
          ],
        ),
      ),
    );
  }
}
