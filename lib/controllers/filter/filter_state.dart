part of 'filter_cubit.dart';

@immutable
abstract class FilterState {}

class FilterInitial extends FilterState {}

class FilterChangeCategoryTab extends FilterState {}

class FilterPriceSilderChange extends FilterState {}

class FilterDistanceSilderChange extends FilterState {}

class FilterClear extends FilterState {}

class FilterApply extends FilterState {}
