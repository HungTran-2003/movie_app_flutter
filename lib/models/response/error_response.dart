import 'dart:ffi';

class ErrorResponse {
  final Bool success;
  final Int statusCode;
  final String statusMessage;

  ErrorResponse(this.success, this.statusCode, this.statusMessage);

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(
      json['success'] as Bool,
      json['statusCode'] as Int,
      json['statusMessage'],
    );
  }
}
