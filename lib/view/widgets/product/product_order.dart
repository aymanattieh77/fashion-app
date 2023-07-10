import 'package:fashion_app/core/utils/colors.dart';
import 'package:fashion_app/core/utils/values.dart';
import 'package:fashion_app/view/widgets/common/text_utils.dart';
import 'package:flutter/material.dart';

class ProductOrder extends StatelessWidget {
  const ProductOrder(
      {super.key,
      required this.image,
      required this.name,
      required this.price,
      required this.date,
      required this.productId});

  final int productId;
  final String image;
  final String name;
  final double price;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p20, vertical: AppPadding.p5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 80,
            height: 100,
            decoration: BoxDecoration(
              color: AppColor.white2,
              borderRadius: BorderRadius.circular(15),
            ),
            child: AspectRatio(
              aspectRatio: 1 / 3,
              child: Image.network(
                image,
                fit: BoxFit.fill,
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextUtils(
                  text: name,
                  fontSize: 14,
                  maxlines: 2,
                  color: Theme.of(context).primaryColorLight,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    TextUtils(
                      text: 'Color : ',
                      fontSize: 14,
                      color: Theme.of(context).primaryColorLight,
                    ),
                    const SizedBox(width: 5),
                    Container(
                      width: 14,
                      height: 14,
                      decoration: const BoxDecoration(
                          color: AppColor.yallowLight, shape: BoxShape.circle),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    TextUtils(
                      text: '\$$price',
                      fontSize: 16,
                      fontWe: FontWe.medium,
                      tr: false,
                    ),
                    const Spacer(),
                    TextUtils(
                      text: date,
                      fontSize: 16,
                      fontWe: FontWe.medium,
                      tr: false,
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
