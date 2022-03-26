class HttpException implements Exception {
  final String message;

  HttpException(this.message);

  @override
  String toString() {
    return "HttpException: $message";
  }
}

class BadRequest implements Exception {
  final String code;
  final String message;

  const BadRequest({
    required this.code,
    required this.message,
  });

  @override
  String toString() {
    return "Bad request: $code, $message";
  }
}
