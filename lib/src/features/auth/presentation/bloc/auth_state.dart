part of 'auth_bloc.dart';

abstract class AuthState {}

class Initial extends AuthState {}

class Loading extends AuthState {}

class Success extends AuthState {
  final String message;

  Success({required this.message});
}

class Error extends AuthState {
  final String errorMessage;

  Error({required this.errorMessage});
}

class PassVisibilityTrigger extends AuthState {}
