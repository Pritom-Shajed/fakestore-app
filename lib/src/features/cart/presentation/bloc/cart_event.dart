part of 'cart_bloc.dart';

sealed class CartEvent {}

class FetchCartItems extends CartEvent {}

class AddToCart extends CartEvent {
  final ProductModelHive product;

  AddToCart({required this.product});
}

class RemoveFromCart extends CartEvent {
  final ProductModelHive product;

  RemoveFromCart({required this.product});
}

class ClearCart extends CartEvent {}
