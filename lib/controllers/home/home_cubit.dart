import 'dart:math';

import 'package:fashion_app/core/errors/exceptions.dart';
import 'package:fashion_app/domain/entities/product/product_category.dart';
import 'package:fashion_app/domain/entities/product/product_entity.dart';
import 'package:fashion_app/domain/usecases/home/get_home_products_usecase.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._usecase) : super(HomeInitial());

  final GetHomeProductsUsecase _usecase;

  int offset = 0;

  List<ProductEntity> menTshrits = [];
  List<ProductEntity> menSutis = [];
  List<ProductEntity> womenDressess = [];
  List<ProductEntity> womenJeans = [];
  List<ProductEntity> menShorts = [];
  List<ProductEntity> menShoesAndSneakers = [];
  List<ProductEntity> tShirtsAndTankTops = [];
  List<ProductEntity> womenTops = [];
  List<ProductEntity> womenShoes = [];

  Future<void> onRefresh() async {
    await getHomeProdcuts();
  }

  int _generateRandomNumber() {
    return Random().nextInt(32);
  }

  List<ProductEntity> prodcutsList(int categoryId) {
    switch (categoryId) {
      case MenCategory.shirts:
        return menTshrits;
      case MenCategory.suitsAndTailoring:
        return menSutis;
      case WomenCategory.dresses:
        return womenDressess;
      case WomenCategory.jeans:
        return womenJeans;
      case MenCategory.shorts:
        return menShorts;
      case MenCategory.shoesAndSneakers:
        return menShoesAndSneakers;
      case MenCategory.tShirtsAndTankTops:
        return tShirtsAndTankTops;
      case WomenCategory.shoes:
        return womenShoes;
      case WomenCategory.tops:
        return womenTops;

      default:
        return [];
    }
  }

  getHomeProdcuts() async {
    emit(HomeProductLoading());
    try {
      await _getProductByCategory(MenCategory.shirts);
      await _getProductByCategory(MenCategory.suitsAndTailoring);
      await _getProductByCategory(WomenCategory.dresses);
      await _getProductByCategory(WomenCategory.jeans);
      await _getProductByCategory(WomenCategory.tops);
      await _getProductByCategory(WomenCategory.shoes);
      await _getProductByCategory(MenCategory.shoesAndSneakers);
      await _getProductByCategory(MenCategory.shorts);
      await _getProductByCategory(MenCategory.tShirtsAndTankTops);
      emit(HomeProductLoaded());
    } on ServerException catch (e) {
      emit(HomeProductsFailure(e.message));
    }
  }

  _getProductByCategory(int categoryID) async {
    offset = _generateRandomNumber();

    (await _usecase.call(HomeProductsInputs(categoryID, offset))).fold(
      (failure) {
        throw ServerException(message: failure.message);
      },
      (products) {
        switch (categoryID) {
          case MenCategory.shirts:
            menTshrits = products;
            break;
          case MenCategory.suitsAndTailoring:
            menSutis = products;
            break;
          case WomenCategory.dresses:
            womenDressess = products;
            break;
          case WomenCategory.jeans:
            womenJeans = products;
            break;
          case MenCategory.shorts:
            menShorts = products;
            break;
          case MenCategory.shoesAndSneakers:
            menShoesAndSneakers = products;
            break;
          case MenCategory.tShirtsAndTankTops:
            tShirtsAndTankTops = products;
            break;
          case WomenCategory.shoes:
            womenShoes = products;
            break;
          case WomenCategory.tops:
            womenTops = products;
            break;
          default:
            menTshrits = products;
        }
      },
    );
  }
}
