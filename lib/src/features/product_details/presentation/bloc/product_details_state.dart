part of 'product_details_bloc.dart';

sealed class ProductDetailsState {}

class Initial extends ProductDetailsState {}

class Loading extends ProductDetailsState {}

class Error extends ProductDetailsState {
  final String errorMessage;

  Error({required this.errorMessage});
}

class ProductDetailsFetched extends ProductDetailsState {
  final ProductModel product;

  ProductDetailsFetched({required this.product});
}
