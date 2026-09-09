class ApiException implements Exception {
  final String message;
  final int statusCode;

  const ApiException({required this.statusCode, required this.message});

  @override
  String toString() => 'ApiException($statusCode): $message';
}
