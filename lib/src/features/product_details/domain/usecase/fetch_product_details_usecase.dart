import 'package:auth/src/features/home/data/models/product_model.dart';
import 'package:auth/src/features/product_details/domain/repositories/product_details_repository.dart';
import 'package:dartz/dartz.dart';

class FetchProductDetailsUsecase {
  const FetchProductDetailsUsecase(this._repo);

  final ProductDetailsRepository _repo;

  Future<Either<String, ProductModel>> call({required String productId}) =>
      _repo.fetchProductDetails(productId: productId);
}
