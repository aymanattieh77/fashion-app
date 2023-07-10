import 'package:dartz/dartz.dart';
import 'package:fashion_app/core/errors/failure.dart';
import 'package:fashion_app/domain/entities/account/address.dart';
import 'package:fashion_app/domain/entities/account/user.dart';
import 'package:fashion_app/domain/entities/product/product_entity.dart';

import 'package:fashion_app/domain/entities/product/product_detail_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> signUp(
      String username, String email, String password);
  Future<Either<Failure, User>> login(String email, String password);
  Future<Either<Failure, void>> resetPassword(String email);
  Future<Either<Failure, void>> signOutFirebase();
  Future<Either<Failure, User>> signInWithGoogle();
  Future<Either<Failure, User>> signInWithFacebook();
  Future<Either<Failure, void>> updateEmail(String newEmail);
}

abstract class HomeRepository {
  Future<Either<Failure, List<ProductEntity>>> getHomeProducts(
      {required int categoryId, required int offset});
}

abstract class ProductDetailRepository {
  Future<Either<Failure, ProductDetailEntity>> getProdcutDetail(
      {required int productId});
}

abstract class CategoryProductRepository {
  Future<Either<Failure, List<ProductEntity>>> getProdcutsByCategoryId({
    required int categoryId,
    String? sort,
    int? priceMin,
    int? priceMax,
    int? offset,
  });
}

abstract class SearchProductRepository {
  Future<Either<Failure, List<ProductEntity>>> getProdcutsBySearch({
    int? offset,
    String? sort,
    int? priceMin,
    int? priceMax,
    required String q,
  });
}

abstract class FirebaseUserRepository {
  Future<Either<Failure, void>> createUserProfile(UserModel user);
  Future<Either<Failure, UserModel>> getUserProfileById();
  Future<Either<Failure, void>> updateUserProfile(UserModel user);
  Future<Either<Failure, void>> deleteUserProfile();
}

abstract class FirebaseAddressRepository {
  Future<Either<Failure, void>> addAddress(AddressEntity addressEntity);
  Future<Either<Failure, List<AddressEntity>>> getSavedAddress();
  Future<Either<Failure, AddressEntity?>> deleteAddress(int id);
  Future<Either<Failure, void>> updateAddress(AddressEntity addressEntity);
  Future<Either<Failure, void>> clearAddress();
}

abstract class FirebaseFavouriteRepository {
  Future<Either<Failure, List<ProductDetailEntity>>> getFavourtiesProducts();
  Future<Either<Failure, void>> deleteFavouriteProduct(int productId);
  Future<Either<Failure, void>> clearFavouritesProducts();
  Future<Either<Failure, void>> addFavouriteProduct(int productId);
}
