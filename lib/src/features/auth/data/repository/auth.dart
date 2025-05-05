import 'package:auth/src/features/auth/data/models/forgetpass.dart';
import 'package:auth/src/features/auth/data/models/signin.dart';
import 'package:auth/src/features/auth/data/models/signup.dart';
import 'package:auth/src/features/auth/data/source/remote/auth/auth_remote_service.dart';
import 'package:auth/src/features/auth/domain/repository/auth.dart';
import 'package:dartz/dartz.dart';


class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteService _authRemoteService;

  AuthRepositoryImpl(this._authRemoteService);

  @override
  Future<Either> signin({required SigninParams params}) async {
    final response = await _authRemoteService.signin(params: params);
    return response.fold(
      (error) => Left(error),
      (success) => Right(success),
    );
  }

  @override
  Future<Either> signup({required SignupParams params}) async {
    final response = await _authRemoteService.signup(params: params);
    return response.fold(
      (error) => Left(error),
      (success) => Right(success),
    );
  }

  @override
  Future<Either> forgetPassword({required ForgetPasswordParams params}) async {
    final response = await _authRemoteService.forgetPassword(params: params);
    return response.fold(
      (error) => Left(error),
      (success) => Right(success),
    );
  }

  @override
  Future<Either> signout() async {
    final response = await _authRemoteService.signout();
    return response.fold(
      (error) => Left(error),
      (success) => Right(success),
    );
  }
}