import 'package:auth/src/features/cart/data/models/product_model_hive.dart';
import 'package:auth/src/features/cart/data/sources/local/cart_local_service.dart';
import 'package:auth/src/features/cart/domain/repositories/cart_repositories.dart';

class CartRepositoriesImpl extends CartRepositories {
  final CartLocalService _localService;

  CartRepositoriesImpl(this._localService);
  @override
  Future<void> addToCart(ProductModelHive product) {
    return _localService.addToCart(product);
  }

  @override
  Future<void> clearCart() {
    return _localService.clearCart();
  }

  @override
  Future<List<ProductModelHive>> getCartItems() {
    return _localService.getCartItems();
  }

  @override
  Future<void> removeFromCart(ProductModelHive product) {
    return _localService.removeFromCart(product);
  }
}
