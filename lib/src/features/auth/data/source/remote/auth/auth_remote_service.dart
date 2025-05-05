import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:io';

import 'package:auth/src/core/network/api_client.dart';
import 'package:auth/src/core/network/enum/method.dart';
import 'package:auth/src/core/network/model/api_response.dart';
import 'package:auth/src/core/network/model/auth_store.dart';
import 'package:auth/src/core/utils/logger/logger_helper.dart';
import 'package:auth/src/features/auth/data/models/forgetpass.dart';
import 'package:auth/src/features/auth/data/models/signin.dart';
import 'package:auth/src/features/auth/data/models/signup.dart';
import 'package:auth/src/injector.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRemoteService {
  Future<Either> signin({required SigninParams params});
  Future<Either> signup({required SignupParams params});
  Future<Either> forgetPassword({required ForgetPasswordParams params});
  Future<Either> signout();
}

class AuthRemoteServiceImpl implements AuthRemoteService {
  final ApiClient _apiClient;

  AuthRemoteServiceImpl(this._apiClient);

  @override
  Future<Either> signin({required SigninParams params}) async {
    try {
      final response = await _apiClient.request(
        ApiClientMethod.post,
        'auth/login',
        data: params.toJson(),
        isAuthRequired: false,
      );
      final Map<String, dynamic> apiResponse = json.decode(response);
      log.i('API Response: $apiResponse');
      // final apiResponse = ApiResponse.fromRawJson(response);
      // if (!apiResponse.success) throw apiResponse.message;
      sl<ApiClient>().authStore = AuthStore(
        accessToken: apiResponse['access_token'],
        refreshToken: apiResponse['refresh_token'],
      );

      // dev.log('AuthStore: ${sl<AuthStore>().isAccessTokenValid}');
      await _apiClient.authStore?.saveData();
      return Right(apiResponse);
    } on SocketException catch (e) {
      return Left('No internet connection. $e');
    } catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either> signup({required SignupParams params}) async {
    try {
      final response = await _apiClient.request(
        ApiClientMethod.post,
        'auth/signup',
        data: {
          'name': params.name,
          'email': params.email,
          'password': params.password,
        },
        isAuthRequired: false,
      );
      final apiResponse = ApiResponse.fromRawJson(response);
      if (!apiResponse.success) throw apiResponse.message;
      sl<ApiClient>().authStore = AuthStore(
        accessToken: apiResponse.data['tokens']['access-token'],
        refreshToken: apiResponse.data['tokens']['refresh-token'],
      );
      await sl<ApiClient>().authStore?.saveData();
      return Right(apiResponse);
    } on SocketException catch (e) {
      return Left('No internet connection. $e');
    } catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either> forgetPassword({required ForgetPasswordParams params}) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      log.i('Password reset email sent');
      return const Right('Password reset email sent');
    } on SocketException catch (e) {
      return Left('No internet connection. $e');
    } catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either> signout() async {
    try {
      await sl<ApiClient>().authStore?.deleteData();
      sl<ApiClient>().authStore = null;
      log.i('Signout successful');
      return const Right('Signout successful');
    } on SocketException catch (e) {
      return Left('No internet connection. $e');
    } catch (e) {
      return Left(e);
    }
  }
}
