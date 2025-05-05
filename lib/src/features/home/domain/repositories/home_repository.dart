import 'package:auth/src/features/home/data/models/product_model.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepository {
  Future<Either<String, List<dynamic>>> fetchCategories();
  Future<Either<String, List<ProductModel>>> fetchProducts();
}
