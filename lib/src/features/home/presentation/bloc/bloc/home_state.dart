part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

class HomeDataFetched extends HomeState {
  final List<dynamic> categories;
  final List<ProductModel> products;


  HomeDataFetched({required this.categories, required this.products});
}

class Loading extends HomeState {}

class Error extends HomeState {
  final String errorMessage;

  Error({required this.errorMessage});
}
