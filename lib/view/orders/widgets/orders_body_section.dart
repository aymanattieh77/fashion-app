import 'package:fashion_app/core/extensions/media_query_extension.dart';
import 'package:fashion_app/core/extensions/theme_extension.dart';
import 'package:fashion_app/core/utils/colors.dart';
import 'package:fashion_app/core/utils/values.dart';
import 'package:fashion_app/view/widgets/common/text_utils.dart';
import 'package:flutter/material.dart';

class OrdersBodySection extends StatelessWidget {
  const OrdersBodySection({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Card(
          margin: const EdgeInsets.all(5),
          child: Container(
            padding: const EdgeInsets.all(AppPadding.p20),
            width: context.fullWidth(),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Divider(
                  color: context.primaryColor,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextUtils(
                        text: "Order Id", color: AppColor.gray, fontSize: 12),
                    TextUtils(
                        text: "465456556", color: AppColor.gray, fontSize: 12),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextUtils(
                        text: "Order date", color: AppColor.gray, fontSize: 12),
                    TextUtils(
                        text: "7/9/2023", color: AppColor.gray, fontSize: 12),
                  ],
                ),
                const SizedBox(height: 10),
                Divider(
                  color: context.primaryColor,
                ),
                const Column(
                  children: [
                    Row(
                      children: [
                        TextUtils(text: "subTotal", fontSize: 14),
                        Spacer(),
                        TextUtils(text: "\$${5545}", fontSize: 14),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class CompletedCancelledOrdersList extends StatelessWidget {
  const CompletedCancelledOrdersList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container();
      },
    );
  }
}
