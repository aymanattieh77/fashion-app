import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fashion_app/config/routes/route_context.dart';
import 'package:fashion_app/config/services/prefs.dart';
import 'package:fashion_app/config/services/service_locator.dart';
import 'package:fashion_app/controllers/filter/filter_cubit.dart';
import 'package:fashion_app/core/functions/function.dart';
import 'package:fashion_app/domain/entities/product/product_entity.dart';
import 'package:fashion_app/domain/usecases/search/get_product_by_search_usecase.dart';
import 'package:fashion_app/view/widgets/common/filtering_widget.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this._usecase) : super(SearchInitial());
  final scrollController = ScrollController();
  final GetProductsBySearchUsecase _usecase;
  final _prefs = getIt<AppPrefs>();
  String searchValue = "";
  List<ProductEntity> searchProducts = [];
  int offset = 0;
  bool isLoadMore = false;

  start(BuildContext context) {
    // add Listener in scrollController
    scrollController.addListener(() {
      loadMoreProducts(context);
    });
  }

  getProdcutsBySearch(BuildContext context, String q,
      {required bool isFirstFetch}) async {
    if (q.isEmpty) {
      return;
    }
    searchValue = q.toLowerCase();
    final searchFilter = initFilter(context);
    if (isFirstFetch) {
      emit(Searchloading());
    }

    (await _usecase.call(searchFilter)).fold(
      (failure) {
        emit(Searchfailure(failure.message));
      },
      (productsList) {
        searchProducts.addAll(productsList);
        isLoadMore = false;
        emit(Searchloaded());
      },
    );
  }

  loadMoreProducts(BuildContext context) async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      isLoadMore = true;
      emit(Searchloaded());
      offset++;
      await getProdcutsBySearch(context, searchValue, isFirstFetch: false);
    }
  }

  initFilter(BuildContext context) {
    final filterCubit = BlocProvider.of<FilterCubit>(context);
    return ProductsSearchInputs(
      q: searchValue,
      priceMax: filterCubit.priceEnd.toInt(),
      priceMin: filterCubit.priceStart.toInt(),
      sort: filterCubit.getSort(),
      offet: offset,
    );
  }

  _load() {
    emit(Searchloaded());
  }

  startSearch(BuildContext context, String searchValue) {
    // getProdcutsBySearch(context, searchValue, isFirstFetch: true);
  }

  onSubmit(BuildContext context, String searchValue) {
    searchProducts.clear();
    _prefs.saveRecentSearches(searchValue);
    emit(SaveRecentSearches());
    getProdcutsBySearch(context, searchValue, isFirstFetch: true);
  }

  clearRecentSearches() {
    _prefs.clearRecentSearches();
    emit(RecentSearchesClear());
    _load();
  }

  showFilter(BuildContext context) {
    showCustomBottomSheet(
      context,
      BlocProvider.value(
        value: BlocProvider.of<FilterCubit>(context),
        child: FillteringWidget(
          applyFiltter: () {
            searchProducts.clear();
            getProdcutsBySearch(context, searchValue, isFirstFetch: true);
            context.back();
          },
        ),
      ),
    );
  }

  void dispose() {
    scrollController.dispose();
  }
}
