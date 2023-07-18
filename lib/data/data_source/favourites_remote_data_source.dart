import 'package:fashion_app/data/remote/firebase_database/firebase_favourite_service.dart';
import 'package:fashion_app/domain/entities/account/favourites.dart';

abstract class FavouriteRemoteDataSource {
  Future<List<ProductsFavourite>> getFavourtiesProducts(String userUid);
  Future<void> deleteFavouriteProduct(int productId, String userUid);
  Future<void> clearFavouritesProducts(String userUid);
  Future<void> addFavouriteProduct(
      ProductsFavourite productFav, String userUid);
}

class FavouriteRemoteDataSourceImpl implements FavouriteRemoteDataSource {
  final FirebaseFavouriteService _service;
  FavouriteRemoteDataSourceImpl(this._service);

  @override
  Future<void> addFavouriteProduct(
      ProductsFavourite productFav, String userUid) async {
    return await _service.addFavouriteProduct(productFav, userUid);
  }

  @override
  Future<void> clearFavouritesProducts(String userUid) async {
    return await _service.clearFavouritesProducts(userUid);
  }

  @override
  Future<void> deleteFavouriteProduct(int productId, String userUid) async {
    return await _service.deleteFavouriteProduct(productId, userUid);
  }

  @override
  Future<List<ProductsFavourite>> getFavourtiesProducts(String userUid) async {
    return await _service.getFavourtiesProducts(userUid);
  }
}
