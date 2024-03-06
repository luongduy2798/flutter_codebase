import 'package:dio/dio.dart';
import 'package:turtle/app/services/local_store/local_store_service.dart';
import '../../../services/local_store/local_store.dart';

class AccessTokenInterceptor extends Interceptor {
  AccessTokenInterceptor() : localStore = LocalStoreService();

  LocalStore localStore;

  @override
  Future<dynamic> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    String token = await localStore.getAccessToken();
    if (token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
      // options.queryParameters.addAll(<String, dynamic>{'access_token': token});
    }
    return super.onRequest(options, handler);
  }
}
