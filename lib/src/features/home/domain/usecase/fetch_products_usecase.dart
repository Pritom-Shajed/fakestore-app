import 'package:auth/src/features/home/data/models/product_model.dart';
import 'package:auth/src/features/home/domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';

class FetchProductsUsecase {
  const FetchProductsUsecase(this._repo);

  final HomeRepository _repo;

  Future<Either<String, List<ProductModel>>> call() => _repo.fetchProducts();
}
