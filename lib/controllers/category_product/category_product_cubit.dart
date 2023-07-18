import 'package:fashion_app/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fashion_app/controllers/filter/filter_cubit.dart';
import 'package:fashion_app/core/functions/function.dart';
import 'package:fashion_app/config/routes/route_context.dart';
import 'package:fashion_app/domain/entities/product/product_entity.dart';
import 'package:fashion_app/domain/usecases/category/get_products_by_filter_usecase.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../view/widgets/common/filtering_widget.dart';

part 'category_product_state.dart';

class CategoryProductCubit extends Cubit<CategoryProductState> {
  CategoryProductCubit(this._usecase) : super(CategoryProductInitial());

  final GetProductsByFilterUsecase _usecase;
  final scrollController = ScrollController();
  int offset = 0;
  bool isLoadMore = false;
  List<ProductEntity> productsList = [];

  void start(BuildContext context, int categoryID) {
    getProducts(context, categoryID, isFirstFetch: true); //first fetch products
    // add Listener in scrollController
    scrollController.addListener(() {
      loadMoreProducts(context, categoryID: categoryID);
    });
  }

  Future<void> getProducts(BuildContext context, int categoryId,
      {required bool isFirstFetch}) async {
    final filter = initFilter(context, categoryId);
    if (isFirstFetch) {
      emit(CategoryProductLoading());
    }
    (await _usecase.call(filter)).fold(
      (failure) {
        emit(CategoryProductFailure(failure.message));
      },
      (products) {
        productsList.addAll(products);
        isLoadMore = false;
        emit(CategoryProductLoaded());
      },
    );
  }

  Future<void> loadMoreProducts(BuildContext context,
      {required int categoryID}) async {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      isLoadMore = true;
      _load();
      offset++;
      await getProducts(context, categoryID, isFirstFetch: false);
    }
  }

  _load() {
    emit(CategoryProductLoaded());
  }

  ProductsFilter initFilter(BuildContext context, int categoryID) {
    final filterCubit = BlocProvider.of<FilterCubit>(context);
    return ProductsFilter(
      categoryId: categoryID,
      priceMax: filterCubit.priceEnd.toInt(),
      priceMin: filterCubit.priceStart.toInt(),
      offset: offset,
      sort: filterCubit.getSort(),
    );
  }

  _applyFiltter(BuildContext context, int categoryId) {
    productsList.clear();
    getProducts(context, categoryId, isFirstFetch: true);
    context.back();
    _backToTop();
  }

  showFilter(BuildContext context, int categoryId) {
    showCustomBottomSheet(
      context,
      BlocProvider.value(
        value: BlocProvider.of<FilterCubit>(context),
        child: FillteringWidget(
          applyFiltter: () {
            _applyFiltter(context, categoryId);
          },
        ),
      ),
    );
  }

  _backToTop() {
    scrollController.animateTo(0, //scroll offset to go
        duration: const Duration(milliseconds: 500), //duration of scroll
        curve: Curves.fastOutSlowIn //scroll type
        );
  }

  dispose() {
    scrollController.dispose();
  }
}
