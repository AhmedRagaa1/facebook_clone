class ServerException implements Exception {
  final String errorMessage;

  const ServerException({
    required this.errorMessage
  });
}