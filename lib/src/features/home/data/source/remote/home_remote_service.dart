import 'dart:convert';
import 'dart:io';

import 'package:auth/src/core/network/api_client.dart';
import 'package:auth/src/core/network/enum/method.dart';
import 'package:auth/src/features/home/data/models/product_model.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRemoteService {
  Future<Either<String, List<dynamic>>> fetchCategories();
  Future<Either<String, List<ProductModel>>> fetchProducts();
}

class HomeRemoteServiceImpl implements HomeRemoteService {
  final ApiClient _apiClient;

  HomeRemoteServiceImpl(this._apiClient);

  @override
  Future<Either<String, List<dynamic>>> fetchCategories() async {
    try {
      final response = await _apiClient.request(
        ApiClientMethod.get,
        'products/categories',
        isAuthRequired: false,
      );
      final List<dynamic> apiResponse = json.decode(response);

      return Right(apiResponse);
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

      final products = apiResponse
          .map((product) => ProductModel.fromJson(product))
          .toList();

      return Right(products);
    } on SocketException catch (e) {
      return Left('No internet connection. ${e.message}');
    } catch (e) {
      return Left(e.toString());
    }
  }
}
