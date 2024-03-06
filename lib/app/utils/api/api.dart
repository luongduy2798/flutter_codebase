import 'package:dio/dio.dart';
import '../../utils/constants.dart';
import 'interceptors/interceptors.dart';

class BaseApi {
  BaseApi()
      : _dio = Dio(BaseOptions(
          baseUrl: Constants.baseUrl,
          connectTimeout:
              const Duration(milliseconds: Constants.connectTimeout),
          receiveTimeout:
              const Duration(milliseconds: Constants.receiveTimeout),
        )) {
    _dio.interceptors.addAll([
      AccessTokenInterceptor(),
      LoggingInterceptor(),
      UnauthorizedInterceptor(),
    ]);
  }
  Dio _dio;
  Dio get dio => _dio;
}
