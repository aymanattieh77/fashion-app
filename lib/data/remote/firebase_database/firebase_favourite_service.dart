import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:fashion_app/core/utils/constants.dart';

import 'package:fashion_app/domain/entities/account/favourites.dart';

abstract class FirebaseFavouriteService {
  Future<List<ProductsFavourite>> getFavourtiesProducts(String userUid);
  Future<void> deleteFavouriteProduct(int productId, String userUid);
  Future<void> clearFavouritesProducts(String userUid);
  Future<void> addFavouriteProduct(
      ProductsFavourite productFav, String userUid);
}

class FirebaseFavouriteServiceImpl implements FirebaseFavouriteService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<void> clearFavouritesProducts(String userUid) async {
    await firestore
        .collection(AppConstants.favouritesCollection)
        .doc(userUid)
        .delete();
  }

  @override
  Future<void> deleteFavouriteProduct(int productId, String userUid) async {
    final doc = await firestore
        .collection(AppConstants.favouritesCollection)
        .doc(userUid)
        .get();

    if (doc.exists && doc.data() != null) {
      final fav = Favourites.fromMap(doc.data()!);

      fav.favourites.removeWhere((fav) => fav.productId == productId);

      await firestore
          .collection(AppConstants.favouritesCollection)
          .doc(userUid)
          .set(fav.toMap());
    }
  }

  @override
  Future<List<ProductsFavourite>> getFavourtiesProducts(String userUid) async {
    final result = await firestore
        .collection(AppConstants.favouritesCollection)
        .doc(userUid)
        .get();
    if (result.exists && result.data() != null) {
      return Favourites.fromMap(result.data()!).favourites;
    }
    return [];
  }

  @override
  Future<void> addFavouriteProduct(
      ProductsFavourite productFav, String userUid) async {
    final doc = await firestore
        .collection(AppConstants.favouritesCollection)
        .doc(userUid)
        .get();

    if (doc.exists && doc.data() != null) {
      final fav = Favourites.fromMap(doc.data()!);
      if (fav.favourites.contains(productFav)) {
        return;
      }
      fav.favourites.add(productFav);
      await firestore
          .collection(AppConstants.favouritesCollection)
          .doc(userUid)
          .set(fav.toMap());
    } else {
      await firestore
          .collection(AppConstants.favouritesCollection)
          .doc(userUid)
          .set(Favourites(favourites: [productFav]).toMap());
    }
  }
}
