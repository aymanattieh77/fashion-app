import 'package:fashion_app/core/extensions/media_query_extension.dart';
import 'package:fashion_app/core/extensions/theme_extension.dart';
import 'package:fashion_app/core/utils/colors.dart';
import 'package:fashion_app/core/utils/strings.dart';
import 'package:fashion_app/view/widgets/common/text_utils.dart';
import 'package:flutter/material.dart';

class AddressTypeChip extends StatelessWidget {
  const AddressTypeChip({
    super.key,
    required this.currnetIndex,
    required this.onTap,
  });

  static const list1 = [
    AppStrings.apartment,
    AppStrings.house,
    AppStrings.office
  ];
  static const list2 = [
    Icons.apartment,
    Icons.house,
    Icons.local_post_office_outlined
  ];
  final int currnetIndex;
  final Function(int) onTap;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(list1.length, (index) {
          return GestureDetector(
            onTap: () {
              onTap.call(index);
            },
            child: Container(
              margin: const EdgeInsets.only(right: 5),
              padding: const EdgeInsets.only(top: 5, left: 5, bottom: 5),
              width: context.setWidth(0.287),
              decoration: BoxDecoration(
                color: currnetIndex == index
                    ? AppColor.orange
                    : context.scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: currnetIndex == index
                      ? AppColor.orange
                      : context.primaryColorLight,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    list2[index],
                    color: currnetIndex == index
                        ? AppColor.white
                        : context.primaryColorLight,
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  Expanded(
                    child: TextUtils(
                      text: list1[index],
                      fontSize: 11,
                      softWrap: false,
                      fontWe: FontWe.bold,
                      color: currnetIndex == index
                          ? AppColor.white
                          : context.primaryColorLight,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
