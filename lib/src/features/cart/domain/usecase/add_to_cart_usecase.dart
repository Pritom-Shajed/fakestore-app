import 'package:auth/src/features/cart/data/models/product_model_hive.dart';
import 'package:auth/src/features/cart/domain/repositories/cart_repositories.dart';

class AddToCartUsecase {
  const AddToCartUsecase(this._repo);

  final CartRepositories _repo;

  Future<void> call({required ProductModelHive product}) => _repo.addToCart(product);
}
