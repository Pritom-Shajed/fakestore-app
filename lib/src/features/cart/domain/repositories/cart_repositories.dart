import 'package:auth/src/features/cart/data/models/product_model_hive.dart';

abstract class CartRepositories {
  Future<void> addToCart(ProductModelHive product);
  Future<List<ProductModelHive>> getCartItems();
  Future<void> removeFromCart(ProductModelHive product);
  Future<void> clearCart();
}
