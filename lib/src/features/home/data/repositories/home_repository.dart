import 'package:auth/src/features/home/data/models/product_model.dart';
import 'package:auth/src/features/home/data/source/remote/home_remote_service.dart';
import 'package:auth/src/features/home/domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';

class HomeRepositoryImpl extends HomeRepository {
  final HomeRemoteService _remoteService;

  HomeRepositoryImpl(this._remoteService);

  @override
  Future<Either<String, List<dynamic>>> fetchCategories() async {
    final response = await _remoteService.fetchCategories();
    return response.fold(
      (error) => Left(error),
      (success) => Right(success),
    );
  }
  
  @override
  Future<Either<String, List<ProductModel>>> fetchProducts() async{
    final response = await _remoteService.fetchProducts();
    return response.fold(
      (error) => Left(error),
      (success) => Right(success),
    );
  }
}
