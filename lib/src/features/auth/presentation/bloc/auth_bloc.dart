import 'package:auth/src/core/router/router.dart';
import 'package:auth/src/features/auth/data/models/signin.dart';
import 'package:auth/src/features/auth/domain/usecase/signin.dart';
import 'package:auth/src/features/auth/domain/usecase/signout.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SigninUseCase _signinUseCase;
  final SignoutUseCase _logoutUseCase;
  bool passwordVisible = false;
  AuthBloc(this._signinUseCase, this._logoutUseCase) : super(Initial()) {
    on<Login>((event, emit) async {
      emit(Loading());
      try {
        Either result = await _signinUseCase.call(params: event.params);
        result.fold(
          (error) {
            emit(Error(errorMessage: error));
            emit(Initial());
          },
          (data) {
            emit(Success(message: 'Successfully logged in'));
          },
        );
      } catch (e) {
        emit(Error(errorMessage: e.toString()));
      }
    });

    on<Logout>((event, emit) async {
      emit(Loading());
      try {
        await _logoutUseCase.call();
        goRouter.refresh();
        emit(Success(message: 'Successfully logged out'));
      } catch (e) {
        emit(Error(errorMessage: e.toString()));
      }
    });

    on<PassObscure>((event, emit) async {
      passwordVisible = !passwordVisible;
      emit(PassVisibilityTrigger());
    });
  }
}
