import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fashion_app/config/services/prefs.dart';
import 'package:fashion_app/core/functions/function.dart';
import 'package:fashion_app/core/utils/strings.dart';
import 'package:fashion_app/domain/entities/account/favourites.dart';
import 'package:fashion_app/domain/usecases/favourites/add_favourite_product_usecase.dart';
import 'package:fashion_app/domain/usecases/favourites/clear_favourites_products_usecase.dart';
import 'package:fashion_app/domain/usecases/favourites/delete_favourite_product_usecase.dart';
import 'package:fashion_app/domain/usecases/favourites/get_favourites_products_usecase.dart';

import '../../config/services/service_locator.dart';

part 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit(
    this._addUsecase,
    this._clearUsecase,
    this._deleteUsecase,
    this._getUsecase,
  ) : super(FavouriteInitial());

  final AddFavouriteProductUsecase _addUsecase;
  final DeleteFavouriteProductUsecase _deleteUsecase;
  final ClearFavouritesProductsUsecase _clearUsecase;
  final GetFavouritesProductsUsecase _getUsecase;
  List<ProductsFavourite> favouriteProducts = [];
  final userUid = getIt<AppPrefs>().userUid;

  Future<void> addProductToFavourites(
    ProductsFavourite productsFavourite,
  ) async {
    // add product to favourties screen
    if (userUid == null) {
      showToastMessage(AppStrings.reLogin);
      return;
    }
    (await _addUsecase.call(AddFavouriteInputs(productsFavourite, userUid!)))
        .fold(
      (failure) {
        showToastMessage(failure.message);
        emit(FavouriteFailure());
      },
      (_) {
        getFavouritesProducts();
      },
    );
  }

  Future<void> clearAllFavouriteProducts() async {
    // clear all favourites products
    if (userUid == null) {
      showToastMessage(AppStrings.reLogin);
      return;
    }
    (await _clearUsecase.call(userUid!)).fold(
      (failure) {
        showToastMessage(failure.message);
        emit(FavouriteFailure());
      },
      (_) {
        getFavouritesProducts();
      },
    );
  }

  Future<void> deleteFavouriteProduct(int productId) async {
    // delete favourite Product
    if (userUid == null) {
      showToastMessage(AppStrings.reLogin);
      return;
    }
    (await _deleteUsecase.call(DeleteFavouriteInputs(productId, userUid!)))
        .fold(
      (failure) {
        showToastMessage(failure.message);
        emit(FavouriteFailure());
      },
      (_) {
        //favouriteProducts.removeWhere((element) => element.id == productId);
        getFavouritesProducts();
      },
    );
  }

  Future<void> getFavouritesProducts() async {
    // get favoureites products
    if (userUid == null) {
      showToastMessage(AppStrings.reLogin);
      return;
    }
    (await _getUsecase.call(userUid!)).fold(
      (failure) {
        showToastMessage(failure.message);
        emit(FavouriteFailure());
      },
      (productList) {
        favouriteProducts = productList;
        emit(FavouriteSuccess());
      },
    );
  }

  Future<void> favBtn(
      ProductsFavourite productsFavourite, int productId) async {
    if (favouriteProducts.isNotEmpty &&
        favouriteProducts.any((element) => element.productId == productId)) {
      await deleteFavouriteProduct(productId);
    } else {
      await addProductToFavourites(productsFavourite);
    }
  }

  bool isFavourite(int productID) {
    return favouriteProducts.any((element) => element.productId == productID);
  }
}
