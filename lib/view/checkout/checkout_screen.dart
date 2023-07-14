import 'package:flutter/material.dart';

import 'package:fashion_app/core/utils/utils.dart';
import 'package:fashion_app/core/utils/values.dart';
import 'package:fashion_app/view/checkout/widgets/billing_information_section.dart';
import 'package:fashion_app/view/checkout/widgets/delivery_address_section.dart';
import 'package:fashion_app/view/checkout/widgets/products_infromation_section.dart';
import 'package:fashion_app/view/widgets/common/custom_appbar.dart';

import 'widgets/swipe_for_payment_button.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppbar(title: AppStrings.checkout),
      body: SingleChildScrollView(
        child: Column(
          children: [
            DeliveryAddressSection(),
            SizedBox(height: AppSizes.s20),
            ProductInfromationSection(),
            SizedBox(height: AppSizes.s20),
            BillingInformationSection(),
            SizedBox(height: AppSizes.s20),
            // PaymentMethodSection(),
            // SizedBox(height: AppSizes.s20),
            SwipeForPaymentButton(),
            SizedBox(height: AppSizes.s20),
          ],
        ),
      ),
    );
  }
}
