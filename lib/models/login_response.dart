class LoginResponse {
  final String token;
  final String userId;

  const LoginResponse({required this.token, required this.userId});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(token: json["token"], userId: json["id"]);
  }
}
