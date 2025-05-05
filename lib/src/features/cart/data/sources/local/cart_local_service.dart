import 'package:auth/src/features/cart/data/models/product_model_hive.dart';
import 'package:auth/src/features/settings/data/repositories/hive_box.dart';

abstract class CartLocalService {
  Future<void> addToCart(ProductModelHive product);
  Future<List<ProductModelHive>> getCartItems();
  Future<void> removeFromCart(ProductModelHive product);
  Future<void> clearCart();
}

class CartLocalServiceImpl implements CartLocalService {
  @override
  Future<void> addToCart(ProductModelHive product) async {
    await Boxes.productsCart.put(product.hashKey, product);
  }

  @override
  Future<List<ProductModelHive>> getCartItems() async {
    return Boxes.productsCart.values.toList();
  }

  @override
  Future<void> removeFromCart(ProductModelHive product) async {
    await Boxes.productsCart.delete(product.hashKey);
  }

  @override
  Future<void> clearCart() async {
    await Boxes.productsCart.clear();
  }
}
