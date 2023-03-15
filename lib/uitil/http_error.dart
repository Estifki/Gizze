class CustomHttpException implements Exception {
  String errorMessage;
  CustomHttpException({required this.errorMessage});

  @override
  String toString() {
    return errorMessage;
  }
}
