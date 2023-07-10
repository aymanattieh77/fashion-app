import 'package:fashion_app/config/routes/route_context.dart';

import 'package:fashion_app/core/utils/colors.dart';
import 'package:fashion_app/core/utils/strings.dart';
import 'package:fashion_app/core/utils/values.dart';
import 'package:fashion_app/view/payment/payment_screen.dart';
import 'package:fashion_app/view/widgets/common/text_utils.dart';
import 'package:flutter/material.dart';

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
          context.goTo(const PaymentScreen());
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
