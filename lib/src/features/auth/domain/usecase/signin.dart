import 'package:auth/src/features/auth/data/models/signin.dart';
import 'package:auth/src/features/auth/domain/repository/auth.dart';
import 'package:dartz/dartz.dart';

class SigninUseCase {
  final AuthRepository _authRepository;

  SigninUseCase(this._authRepository);

  Future<Either> call({required SigninParams params}) async {
    return _authRepository.signin(params: params);
  }
}
