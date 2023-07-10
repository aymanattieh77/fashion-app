import 'package:fashion_app/core/functions/state_renderer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fashion_app/controllers/search/search_cubit.dart';
import 'package:fashion_app/view/widgets/product/product_card_gridview.dart';

class SearchProductsGirdview extends StatelessWidget {
  const SearchProductsGirdview({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit, SearchState>(
      listener: (context, state) {
        if (state is Searchfailure) {
          showFullScreenErrorState(context, state.message);
        }
      },
      builder: (context, state) {
        if (state is Searchloading) {
          return loadingCircularWidget();
        } else if (state is Searchloaded) {
          return ProductCardGirdview(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            products: BlocProvider.of<SearchCubit>(context).searchProducts,
          );
        } else {
          return Container();
        }
      },
    );
  }
}
