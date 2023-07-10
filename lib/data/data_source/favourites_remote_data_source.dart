import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_app/data/remote/firebase_database/firebase_favourite_service.dart';

abstract class FavouriteRemoteDataSource {
  Future<DocumentSnapshot<Map<String, dynamic>>> getFavourtiesProducts();
  Future<void> deleteFavouriteProduct(int productId);
  Future<void> clearFavouritesProducts();
  Future<void> addFavouriteProduct(int productId);
}

class FavouriteRemoteDataSourceImpl implements FavouriteRemoteDataSource {
  final FirebaseFavouriteService _service;
  FavouriteRemoteDataSourceImpl(this._service);
  @override
  Future<void> addFavouriteProduct(int productId) async {
    return _service.addFavouriteProduct(productId);
  }

  @override
  Future<void> clearFavouritesProducts() {
    return _service.clearFavouritesProducts();
  }

  @override
  Future<void> deleteFavouriteProduct(int productId) {
    return _service.deleteFavouriteProduct(productId);
  }

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> getFavourtiesProducts() {
    return _service.getFavourtiesProducts();
  }
}
