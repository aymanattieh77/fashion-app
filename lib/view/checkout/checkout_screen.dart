import 'package:fashion_app/controllers/address/address_cubit.dart';
import 'package:flutter/material.dart';

import 'package:fashion_app/core/utils/utils.dart';
import 'package:fashion_app/core/utils/values.dart';
import 'package:fashion_app/view/checkout/widgets/billing_information_section.dart';
import 'package:fashion_app/view/checkout/widgets/delivery_address_section.dart';
import 'package:fashion_app/view/checkout/widgets/products_infromation_section.dart';
import 'package:fashion_app/view/widgets/common/custom_appbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/swipe_for_payment_button.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AddressCubit>(context).getSavedAddress();
  }

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
            SwipeForPaymentButton(),
            SizedBox(height: AppSizes.s20),
          ],
        ),
      ),
    );
  }
}
