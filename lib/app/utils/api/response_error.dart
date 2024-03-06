import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';

class ResponseError extends Equatable {
  final int? code;
  final String? message;

  const ResponseError({this.code, this.message});

  ResponseError copyWith({
    int? code,
    String? message,
  }) {
    return ResponseError(
      code: code ?? this.code,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [code, message];

  static ResponseError? bindResponseError(Object error) {
    try {
      if (error is DioException) {
        return ResponseError(
            code: error.response?.statusCode,
            message: error.response?.statusMessage);
      } else {
        return ResponseError(message: error.toString());
      }
    } catch (e) {
      return null;
    }
  }
}
