import 'package:auth/src/features/auth/domain/repository/auth.dart';
import 'package:dartz/dartz.dart';

class SignoutUseCase {
  final AuthRepository _authRepository;

  SignoutUseCase(this._authRepository);

  Future<Either> call() async {
    return await _authRepository.signout();
  }
}
