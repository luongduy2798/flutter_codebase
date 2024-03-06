import 'package:dio/dio.dart';
import '../../events/rx_events.dart';
import '../../rx_bus.dart';

class UnauthorizedInterceptor extends Interceptor {
  UnauthorizedInterceptor();

  // @override
  // void onResponse(Response response, ResponseInterceptorHandler handler) {
  //   print('UnauthorizedInterceptor ${response.statusCode}');
  //   if (response.statusCode == 401) {
  //     // send notify not authorized
  //     RxBus.post(UnauthenticatedEvent());
  //   }
  //   return handler.next(response);
  // }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      // send notify not authorized
      RxBus.post(UnauthenticatedEvent());
    }
    super.onError(err, handler);
  }
}
