import 'package:auth/src/features/cart/domain/repositories/cart_repositories.dart';

class ClearCartUsecase {
  const ClearCartUsecase(this._repo);

  final CartRepositories _repo;

  Future<void> call() => _repo.clearCart();
}
