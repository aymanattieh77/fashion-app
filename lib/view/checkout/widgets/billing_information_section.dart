import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fashion_app/controllers/checkout/checkout_cubit.dart';
import 'package:fashion_app/core/utils/colors.dart';
import 'package:fashion_app/core/utils/strings.dart';
import 'package:fashion_app/core/utils/values.dart';
import 'package:fashion_app/view/widgets/common/text_utils.dart';

class BillingInformationSection extends StatelessWidget {
  const BillingInformationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppPadding.p20),
          child: TextUtils(
            text: AppStrings.billingInformation,
            fontSize: 18,
            fontWe: FontWe.medium,
          ),
        ),
        BillingInformationCard(),
      ],
    );
  }
}

class BillingInformationCard extends StatelessWidget {
  const BillingInformationCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(AppPadding.p20),
          child: Column(
            children: [
              _textWithPrice(AppStrings.deliveryFee,
                  BlocProvider.of<CheckoutCubit>(context).getDeliveryFee()),
              _textWithPrice(AppStrings.tax,
                  BlocProvider.of<CheckoutCubit>(context).getFax()),
              _textWithPrice(
                  AppStrings.subtotal,
                  BlocProvider.of<CheckoutCubit>(context)
                      .getPriceSubTotal(context)),
              const SizedBox(height: AppSizes.s10),
              _textWithPrice(
                  AppStrings.total,
                  BlocProvider.of<CheckoutCubit>(context)
                      .getPriceTotal(context)),
            ],
          ),
        ),
      ),
    );
  }

  Row _textWithPrice(String title, double price) {
    return Row(
      children: [
        TextUtils(
          text: title,
          fontSize: 14,
          color: AppColor.gray,
        ),
        const Spacer(),
        TextUtils(text: '\$$price', fontSize: 16),
      ],
    );
  }
}
