import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:fashion_app/config/services/prefs.dart';

import 'package:fashion_app/core/utils/constants.dart';

import 'package:fashion_app/domain/entities/account/favourites.dart';

import 'package:fashion_app/config/services/service_locator.dart';

abstract class FirebaseFavouriteService {
  Future<DocumentSnapshot<Map<String, dynamic>>> getFavourtiesProducts();
  Future<void> deleteFavouriteProduct(int productId);
  Future<void> clearFavouritesProducts();
  Future<void> addFavouriteProduct(int productId);
}

class FirebaseFavouriteServiceImpl implements FirebaseFavouriteService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final userId = getIt<AppPrefs>().userUid;
  @override
  Future<void> clearFavouritesProducts() async {
    await firestore
        .collection(AppConstants.favouritesCollection)
        .doc(userId)
        .delete();
  }

  @override
  Future<void> deleteFavouriteProduct(int productId) async {
    final doc = await firestore
        .collection(AppConstants.favouritesCollection)
        .doc(userId)
        .get();

    if (doc.exists && doc.data() != null) {
      final fav = Favourites.fromMap(doc.data()!);

      fav.productsId.removeWhere((id) => id == productId);

      await firestore
          .collection(AppConstants.favouritesCollection)
          .doc(userId)
          .set(fav.toMap());
    }
  }

  @override
  getFavourtiesProducts() async {
    return await firestore
        .collection(AppConstants.favouritesCollection)
        .doc(userId)
        .get();
  }

  @override
  Future<void> addFavouriteProduct(int productId) async {
    final doc = await firestore
        .collection(AppConstants.favouritesCollection)
        .doc(userId)
        .get();

    if (doc.exists && doc.data() != null) {
      final fav = Favourites.fromMap(doc.data()!);
      if (fav.productsId.contains(productId)) {
        return;
      }
      fav.productsId.add(productId);
      await firestore
          .collection(AppConstants.favouritesCollection)
          .doc(userId)
          .set(fav.toMap());
    } else {
      await firestore
          .collection(AppConstants.favouritesCollection)
          .doc(userId)
          .set(Favourites(productsId: [productId]).toMap());
    }
  }
}
