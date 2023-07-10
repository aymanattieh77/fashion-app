import 'package:fashion_app/core/functions/function.dart';
import 'package:fashion_app/domain/entities/product/product_detail_entity.dart';
import 'package:fashion_app/domain/usecases/base_usecase.dart';
import 'package:fashion_app/domain/usecases/favourites/add_favourite_product_usecase.dart';
import 'package:fashion_app/domain/usecases/favourites/clear_favourites_products_usecase.dart';
import 'package:fashion_app/domain/usecases/favourites/delete_favourite_product_usecase.dart';
import 'package:fashion_app/domain/usecases/favourites/get_favourites_products_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  List<ProductDetailEntity> favouriteProducts = [];
  Future<void> addProductToFavourites(int productId) async {
    // add product to favourties screen

    (await _addUsecase.call(productId)).fold(
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
    (await _clearUsecase.call(const NoParameters())).fold(
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
    (await _deleteUsecase.call(productId)).fold(
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

    (await _getUsecase.call(const NoParameters())).fold(
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

  favBtn(int productID) async {
    if (favouriteProducts.isNotEmpty &&
        favouriteProducts.any((element) => element.id == productID)) {
      await deleteFavouriteProduct(productID);
    } else {
      await addProductToFavourites(productID);
    }
  }

  bool isFavourite(int productID) {
    return favouriteProducts.any((element) => element.id == productID);
  }
}
