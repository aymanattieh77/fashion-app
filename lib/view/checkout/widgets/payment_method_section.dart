import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:fashion_app/controllers/checkout/checkout_cubit.dart';
import 'package:fashion_app/core/utils/assets.dart';
import 'package:fashion_app/core/utils/colors.dart';
import 'package:fashion_app/core/utils/strings.dart';
import 'package:fashion_app/core/utils/values.dart';
import 'package:fashion_app/view/widgets/common/text_utils.dart';

class PaymentMethodSection extends StatelessWidget {
  const PaymentMethodSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: AppPadding.p20),
          child: TextUtils(
            text: AppStrings.paymentMethod,
            fontSize: 18,
            fontWe: FontWe.medium,
          ),
        ),
        const SizedBox(height: AppSizes.s5),
        Padding(
          padding: const EdgeInsets.only(
            left: AppPadding.p20,
            right: AppPadding.p20 * 2,
          ),
          child: BlocBuilder<CheckoutCubit, CheckoutState>(
            builder: (_, state) {
              return PaymentMethodRow(
                currnetTab:
                    BlocProvider.of<CheckoutCubit>(context).currnetPaymentTap,
                onTap: BlocProvider.of<CheckoutCubit>(context)
                    .onChangePaymentMethod,
                paymentImages: const [
                  AssetsIconPath.applePay,
                  AssetsIconPath.visa,
                  AssetsIconPath.mastercard,
                  AssetsIconPath.paypal
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class PaymentMethodRow extends StatelessWidget {
  const PaymentMethodRow({
    super.key,
    required this.paymentImages,
    required this.currnetTab,
    required this.onTap,
  });
  final List<String> paymentImages;
  final int currnetTab;
  final Function(int) onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        paymentImages.length,
        (index) {
          return InkWell(
            onTap: () {
              onTap.call(index);
            },
            child: Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                Container(
                  padding: const EdgeInsets.all(AppPadding.p20 - 10),
                  child: SvgPicture.asset(paymentImages[index]),
                ),
                if (currnetTab == index)
                  Container(
                    width: AppSizes.s10,
                    height: AppSizes.s10,
                    decoration: const BoxDecoration(
                        color: AppColor.green, shape: BoxShape.circle),
                    child: const Icon(
                      Icons.check,
                      color: AppColor.white,
                      size: 10,
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
