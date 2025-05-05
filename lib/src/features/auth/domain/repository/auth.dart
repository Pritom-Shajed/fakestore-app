import 'package:auth/src/features/auth/data/models/forgetpass.dart';
import 'package:auth/src/features/auth/data/models/signin.dart';
import 'package:auth/src/features/auth/data/models/signup.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either> signin({required SigninParams params});
  Future<Either> signup({required SignupParams params});
  Future<Either> forgetPassword({required ForgetPasswordParams params});
  Future<Either> signout();
}
