import 'package:fashion_app/core/functions/state_renderer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fashion_app/controllers/search/search_cubit.dart';
import 'package:fashion_app/core/utils/colors.dart';
import 'package:fashion_app/core/utils/strings.dart';
import 'package:fashion_app/core/utils/values.dart';
import 'package:fashion_app/view/search/widgets/recent_searches_section.dart';
import 'package:fashion_app/view/search/widgets/search_products_girdview.dart';
import 'package:fashion_app/view/widgets/common/text_utils.dart';

import 'custom_search_field.dart';

class SearchBodySection extends StatelessWidget {
  const SearchBodySection({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: BlocProvider.of<SearchCubit>(context).scrollController,
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          const CustomSearchField(),
          searchResultText(),
          const RecentSearchesSection(),
          const SizedBox(height: AppSizes.s20),
          const SearchProductsGirdview(),
          _loadingMoreProdcuts()
        ],
      ),
    );
  }

  Widget _loadingMoreProdcuts() {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (BlocProvider.of<SearchCubit>(context).isLoadMore) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: loadingCircularWidget(),
          );
        }
        return Container();
      },
    );
  }

  Widget searchResultText() {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.p20, vertical: AppPadding.p20 - 10),
          child: Row(
            children: [
              const TextUtils(
                text: AppStrings.searchResultsShowingFor,
                fontSize: 16,
                color: AppColor.orange,
                fontWe: FontWe.medium,
              ),
              Text(
                '"${BlocProvider.of<SearchCubit>(context).searchValue}"',
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColor.orange,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
