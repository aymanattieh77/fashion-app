import 'package:fashion_app/config/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fashion_app/controllers/cart/cart_cubit.dart';
import 'package:fashion_app/config/routes/route_context.dart';
import 'package:fashion_app/core/utils/strings.dart';
import 'package:fashion_app/core/utils/values.dart';
import 'package:fashion_app/view/widgets/common/custom_elevated_button.dart';
import 'package:fashion_app/view/widgets/common/text_utils.dart';

class CheckoutAndSubtotal extends StatelessWidget {
  const CheckoutAndSubtotal({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        if (BlocProvider.of<CartCubit>(context).carts.isEmpty) {
          return Container();
        }
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
              child: Row(
                children: [
                  const TextUtils(text: AppStrings.subtotal, fontSize: 14),
                  const Spacer(),
                  BlocBuilder<CartCubit, CartState>(
                    builder: (context, state) {
                      return TextUtils(
                          text:
                              '\$${BlocProvider.of<CartCubit>(context).subTotal()}',
                          fontSize: 18,
                          fontWe: FontWe.medium);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSizes.s20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p50),
              child: CustomElevatedButton(
                label: AppStrings.checkout,
                press: () {
                  context.goToNamed(route: Routes.checkout);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
