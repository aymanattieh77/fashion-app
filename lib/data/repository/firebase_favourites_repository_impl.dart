import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:fashion_app/core/errors/failure.dart';
import 'package:fashion_app/data/data_source/favourites_remote_data_source.dart';
import 'package:fashion_app/data/data_source/product_remote_data_source.dart';
import 'package:fashion_app/data/mappers/product_mappers.dart';
import 'package:fashion_app/domain/entities/account/favourites.dart';
import 'package:fashion_app/domain/entities/product/product_detail_entity.dart';
import 'package:fashion_app/domain/repository/repositories.dart';

class FirebaseFavouritesRepositoryImpl implements FirebaseFavouriteRepository {
  final FavouriteRemoteDataSource _favDataSource;
  final ProductRemoteDataSource _productDataSource;
  FirebaseFavouritesRepositoryImpl(
      this._favDataSource, this._productDataSource);
  @override
  Future<Either<Failure, void>> addFavouriteProduct(int productId) async {
    try {
      await _favDataSource.addFavouriteProduct(productId);
      return const Right(Void);
    } catch (e) {
      return Left(FirebaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> clearFavouritesProducts() async {
    try {
      await _favDataSource.clearFavouritesProducts();
      return const Right(Void);
    } catch (e) {
      return Left(FirebaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteFavouriteProduct(int productId) async {
    try {
      await _favDataSource.deleteFavouriteProduct(productId);
      return const Right(Void);
    } catch (e) {
      return Left(FirebaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductDetailEntity>>>
      getFavourtiesProducts() async {
    try {
      final doc = await _favDataSource.getFavourtiesProducts();
      final products = <ProductDetailEntity>[];
      if (doc.exists && doc.data() != null) {
        final productIdList = Favourites.fromMap(doc.data()!).productsId;
        for (var productId in productIdList) {
          products.add(
              (await _productDataSource.getProdcutDetail(productId: productId))
                  .toDomain());
        }
        return Right(products);
      }
      return const Left(FirebaseFailure('There No favourites Products'));
    } catch (e) {
      return Left(FirebaseFailure(e.toString()));
    }
  }
}
