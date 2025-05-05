import 'package:auth/src/features/home/data/models/product_model.dart';
import 'package:auth/src/features/product_details/data/sources/remote/product_details_remote_service.dart';
import 'package:auth/src/features/product_details/domain/repositories/product_details_repository.dart';
import 'package:dartz/dartz.dart';

class ProductDetailsRepositoryImpl extends ProductDetailsRepository {
  final ProductDetailsRemoteService _remoteService;
  ProductDetailsRepositoryImpl(this._remoteService);
  @override
  Future<Either<String, ProductModel>> fetchProductDetails({required String productId}) async {
    final response = await _remoteService.fetchProductDetails(productId: productId);
    return response.fold(
      (error) => Left(error),
      (success) => Right(success),
    );
  }
}
