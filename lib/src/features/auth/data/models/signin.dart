class SigninParams {
  final String email;
  final String password;

  SigninParams({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      _Json.email: email,
      _Json.password: password,
    };
  }
}

class _Json {
  static const email = 'email';
  static const password = 'password';
}