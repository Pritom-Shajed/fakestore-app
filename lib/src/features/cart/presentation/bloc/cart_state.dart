part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

class CartItemsFetched extends CartState {
  final List<ProductModelHive> products;

  CartItemsFetched({required this.products});
}

class Loading extends CartState {}

class Error extends CartState {
  final String errorMessage;

  Error({required this.errorMessage});
}

