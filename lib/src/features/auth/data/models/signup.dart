class SignupParams {
  final String name;
  final String email;
  final String password;

  SignupParams({
    required this.name,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      _Json.name: name,
      _Json.email: email,
      _Json.password: password,
    };
  }
}

class _Json {
  static const name = 'name';
  static const email = 'email';
  static const password = 'password';
}