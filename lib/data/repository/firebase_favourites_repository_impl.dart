// ignore_for_file: void_checks

import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:fashion_app/core/errors/failure.dart';
import 'package:fashion_app/data/data_source/favourites_remote_data_source.dart';
import 'package:fashion_app/domain/entities/account/favourites.dart';
import 'package:fashion_app/domain/repository/repositories.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseFavouritesRepositoryImpl implements FirebaseFavouriteRepository {
  final FavouriteRemoteDataSource _favDataSource;

  FirebaseFavouritesRepositoryImpl(this._favDataSource);
  @override
  Future<Either<Failure, void>> addFavouriteProduct(
      ProductsFavourite productFav, String userUid) async {
    try {
      await _favDataSource.addFavouriteProduct(productFav, userUid);
      return const Right(Void);
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure(e.message ?? e.toString()));
    } catch (e) {
      return Left(FirebaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> clearFavouritesProducts(String userUid) async {
    try {
      await _favDataSource.clearFavouritesProducts(userUid);
      return const Right(Void);
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure(e.message ?? e.toString()));
    } catch (e) {
      return Left(FirebaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteFavouriteProduct(
      int productId, String userUid) async {
    try {
      await _favDataSource.deleteFavouriteProduct(productId, userUid);
      return const Right(Void);
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure(e.message ?? e.toString()));
    } catch (e) {
      return Left(FirebaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductsFavourite>>> getFavourtiesProducts(
      String userUid) async {
    try {
      final doc = await _favDataSource.getFavourtiesProducts(userUid);

      return Right(doc);
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure(e.message ?? e.toString()));
    } catch (e) {
      return Left(FirebaseFailure(e.toString()));
    }
  }
}
