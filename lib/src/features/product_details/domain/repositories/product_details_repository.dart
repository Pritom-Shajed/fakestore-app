import 'package:auth/src/features/home/data/models/product_model.dart';
import 'package:dartz/dartz.dart';

abstract class ProductDetailsRepository {
  Future<Either<String, ProductModel>> fetchProductDetails({required String productId});
}
