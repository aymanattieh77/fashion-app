import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fashion_app/controllers/search/search_cubit.dart';
import 'package:fashion_app/core/extensions/theme_extension.dart';
import 'package:fashion_app/config/services/prefs.dart';
import 'package:fashion_app/config/services/service_locator.dart';
import 'package:fashion_app/core/utils/colors.dart';
import 'package:fashion_app/core/utils/strings.dart';
import 'package:fashion_app/core/utils/values.dart';
import 'package:fashion_app/view/widgets/common/text_utils.dart';

class RecentSearchesSection extends StatelessWidget {
  const RecentSearchesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        final recentSearches = getIt<AppPrefs>().getRecentSearches();
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppPadding.p20, vertical: AppPadding.p20 - 10),
            child: Column(
              children: [
                Row(
                  children: [
                    const TextUtils(
                        text: AppStrings.recentSearches,
                        fontSize: 16,
                        color: AppColor.orange,
                        fontWe: FontWe.medium),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        BlocProvider.of<SearchCubit>(context)
                            .clearRecentSearches();
                      },
                      child: TextUtils(
                        text: AppStrings.clear,
                        color: context.primaryColorLight,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                ...List.generate(recentSearches.length, (index) {
                  return _recentSearch(
                    context,
                    recentSearches[index],
                    () {
                      BlocProvider.of<SearchCubit>(context)
                          .onSubmit(context, recentSearches[index]);
                    },
                  );
                }).toList(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _recentSearch(BuildContext context, value, Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            Icons.access_time,
            color: context.primaryColorLight,
          ),
          const SizedBox(width: 5),
          Text(
            value,
            style: TextStyle(color: context.primaryColorLight),
          ),
        ],
      ),
    );
  }
}
