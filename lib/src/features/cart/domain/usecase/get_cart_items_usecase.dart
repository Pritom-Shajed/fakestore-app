import 'package:auth/src/features/cart/data/models/product_model_hive.dart';
import 'package:auth/src/features/cart/domain/repositories/cart_repositories.dart';

class GetCartItemsUsecase {
  const GetCartItemsUsecase(this._repo);

  final CartRepositories _repo;

  Future<List<ProductModelHive>> call() => _repo.getCartItems();
}
