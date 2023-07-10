import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'filter_state.dart';

const priceDesc = 'pricedesc';
const priceAsc = 'priceasc';
const freshness = 'freshness';

class FilterCubit extends Cubit<FilterState> {
  FilterCubit() : super(FilterInitial());

  int currnetSortTab = 0;
  double priceStart = 5.0;
  double priceEnd = 360.0;

  List<String> sorts = [freshness, priceDesc, priceAsc];

  void onTap(int index) {
    currnetSortTab = index;
    emit(FilterChangeCategoryTab());
  }

  onRangePriceChange(RangeValues rangeValue) {
    priceStart = rangeValue.start;
    priceEnd = rangeValue.end;
    emit(FilterPriceSilderChange());
  }

  String getSort() {
    return sorts[currnetSortTab];
  }

  clear() {
    currnetSortTab = 0;
    priceStart = 20.0;
    priceEnd = 100.0;

    emit(FilterClear());
  }

  List<String> get priceText {
    String start = '\$${priceStart.toInt()}';
    String end = '\$${priceEnd.toInt()}';

    return [start, end];
  }

  void applyFiltter() {
    // Todo
  }
}
