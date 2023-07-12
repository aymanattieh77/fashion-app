import 'package:fashion_app/config/routes/route_context.dart';
import 'package:fashion_app/core/functions/function.dart';

import 'package:fashion_app/core/utils/colors.dart';
import 'package:fashion_app/core/utils/strings.dart';
import 'package:fashion_app/core/utils/values.dart';
import 'package:fashion_app/view/payment/payment_screen.dart';
import 'package:fashion_app/view/widgets/common/custom_alert_dialog.dart';
import 'package:fashion_app/view/widgets/common/custom_elevated_button.dart';
import 'package:fashion_app/view/widgets/common/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

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
          showCustomDialog(
            context,
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const TextUtils(text: "Visa1"),
                  CardFormField(
                    controller: CardFormEditController(),
                  ),
                  CustomElevatedButton(label: "Pay", press: () {}),
                ],
              ),
            ),
          );

          //context.goTo(const PaymentScreen());
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
