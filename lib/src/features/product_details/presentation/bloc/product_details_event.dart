part of 'product_details_bloc.dart';


sealed class ProductDetailsEvent {}

class FetchProductDetails extends ProductDetailsEvent {
  final String productId;

  FetchProductDetails({required this.productId});
}
