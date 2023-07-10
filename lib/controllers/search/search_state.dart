// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'search_cubit.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class Searchloading extends SearchState {}

class Searchloaded extends SearchState {}

class Searchfailure extends SearchState {
  String message;
  Searchfailure(this.message);
}

class RecentSearchesClear extends SearchState {}

class SaveRecentSearches extends SearchState {}
