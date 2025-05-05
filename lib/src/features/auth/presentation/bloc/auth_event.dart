part of 'auth_bloc.dart';

sealed class AuthEvent {}

class Login extends AuthEvent {
  final SigninParams params;

  Login({required this.params});
}

class Logout extends AuthEvent {}

class PassObscure extends AuthEvent {}
