class ResponseObject {
  final bool isSucces;
  final int statusCode;
  final dynamic responseBody;
  final String? errorMessage;

  ResponseObject( {
    required this.isSucces,
    required this.statusCode,
    required this.responseBody,
    this.errorMessage = '',
  });
}
