import 'package:fashion_app/controllers/filter/filter_cubit.dart';
import 'package:fashion_app/core/extensions/media_query_extension.dart';
import 'package:fashion_app/config/routes/route_context.dart';
import 'package:fashion_app/core/utils/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fashion_app/core/utils/utils.dart';

import 'package:fashion_app/view/widgets/common/custom_elevated_button.dart';
import 'package:fashion_app/view/widgets/common/text_utils.dart';

class FillteringWidget extends StatelessWidget {
  final Function() applyFiltter;

  const FillteringWidget({
    super.key,
    required this.applyFiltter,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<FilterCubit>(context);
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
          colors: [Theme.of(context).cardColor, Theme.of(context).cardColor],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      height: context.setHeight(0.75),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p20, vertical: AppPadding.p20 - 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: cubit.clear,
                  child: const TextUtils(
                    text: AppStrings.clear,
                    fontSize: 14,
                  ),
                ),
                const TextUtils(
                  text: AppStrings.filters,
                  fontSize: 19,
                ),
                InkWell(
                  onTap: () {
                    context.back();
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                        color: AppColor.white2, shape: BoxShape.circle),
                    child: const Icon(Icons.close),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.s15),
            const Divider(thickness: 1.2),
            const SizedBox(height: AppSizes.s15),
            const TextUtils(
              text: AppStrings.sort,
              fontSize: 18,
              fontWe: FontWe.medium,
            ),
            const SizedBox(height: AppSizes.s5),
            BlocBuilder<FilterCubit, FilterState>(
              builder: (context, state) {
                return CustomCategoryTab(
                  labels: const [
                    AppStrings.freshness,
                    AppStrings.priceHighToLow,
                    AppStrings.priceLowToHigh,
                  ],
                  currnetTap: cubit.currnetSortTab,
                  onTap: cubit.onTap,
                );
              },
            ),
            const SizedBox(height: AppSizes.s20),
            BlocBuilder<FilterCubit, FilterState>(
              builder: (context, state) {
                return CustomRangeSilder(
                  title: AppStrings.pricing,
                  textRange: cubit.priceText,
                  min: 5.0,
                  max: 360.0,
                  startValue: cubit.priceStart,
                  endValue: cubit.priceEnd,
                  onChanged: cubit.onRangePriceChange,
                );
              },
            ),
            const SizedBox(height: AppSizes.s10),
            Center(
              child: CustomElevatedButton(
                label: AppStrings.applyFilter,
                press: applyFiltter,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomRangeSilder extends StatelessWidget {
  const CustomRangeSilder(
      {super.key,
      required this.max,
      required this.min,
      required this.title,
      required this.startValue,
      required this.endValue,
      this.onChanged,
      required this.textRange});
  final double max;
  final double min;
  final String title;
  final List<String> textRange;
  final double startValue;
  final double endValue;
  final Function(RangeValues)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            TextUtils(
              text: title,
              fontSize: 18,
              fontWe: FontWe.medium,
            ),
            const Spacer(),
            TextUtils(
              text: '${textRange[0]}-${textRange[1]}',
              fontSize: 12,
              tr: false,
              fontWe: FontWe.semiBold,
            ),
          ],
        ),
        const SizedBox(height: AppSizes.s10),
        RangeSlider(
          values: RangeValues(startValue, endValue),
          onChanged: onChanged,
          activeColor: AppColor.orange,
          labels: RangeLabels(textRange[0], textRange[1]),
          max: max,
          min: min,
        ),
      ],
    );
  }
}

class CustomCategoryTab extends StatelessWidget {
  const CustomCategoryTab(
      {super.key,
      required this.labels,
      required this.onTap,
      required this.currnetTap});

  final List<String> labels;
  final Function(int) onTap;
  final int currnetTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(labels.length, (index) {
        return Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 0.0,
                backgroundColor: currnetTap == index
                    ? AppColor.orange
                    : Theme.of(context).cardColor),
            onPressed: () {
              onTap.call(index);
            },
            child: TextUtils(
              text: labels[index],
              fontSize: 12,
              color: currnetTap == index
                  ? AppColor.white
                  : Theme.of(context).primaryColor,
            ),
          ),
        );
      }),
    );
  }
}
