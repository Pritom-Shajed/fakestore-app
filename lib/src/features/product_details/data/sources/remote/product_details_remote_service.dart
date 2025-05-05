import 'dart:convert';
import 'dart:io';

import 'package:auth/src/core/network/api_client.dart';
import 'package:auth/src/core/network/enum/method.dart';
import 'package:auth/src/features/home/data/models/product_model.dart';
import 'package:dartz/dartz.dart';

abstract class ProductDetailsRemoteService {
  Future<Either<String, ProductModel>> fetchProductDetails({required String productId});
}

class ProductDetailsRemoteServiceImpl implements ProductDetailsRemoteService {
  final ApiClient _apiClient;

  ProductDetailsRemoteServiceImpl(this._apiClient);

  @override
  Future<Either<String, ProductModel>> fetchProductDetails({required String productId}) async {
    try {
      final response = await _apiClient.request(
        ApiClientMethod.get,
        'products/$productId',
        isAuthRequired: false,
      );
      final dynamic apiResponse = json.decode(response);

      final product = ProductModel.fromJson(apiResponse);
      return Right(product);
    } on SocketException catch (e) {
      return Left('No internet connection. ${e.message}');
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<ProductModel>>> fetchProducts() async {
    try {
      final response = await _apiClient.request(
        ApiClientMethod.get,
        'products',
        isAuthRequired: false,
      );
      final List<dynamic> apiResponse = json.decode(response);

      final products = apiResponse.map((product) => ProductModel.fromJson(product)).toList();

      return Right(products);
    } on SocketException catch (e) {
      return Left('No internet connection. ${e.message}');
    } catch (e) {
      return Left(e.toString());
    }
  }
}
