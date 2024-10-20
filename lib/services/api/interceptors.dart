import 'package:dio/dio.dart';

class CustomInterceptors extends InterceptorsWrapper {
  CustomInterceptors()
      : super(
          onRequest:
              (RequestOptions options, RequestInterceptorHandler handler) {
            return handler.next(options);
          },
          onResponse: (Response response, ResponseInterceptorHandler handler) {
            return handler.next(response);
          },
          onError: (DioException error, ErrorInterceptorHandler handler) {
            return handler.next(error);
          },
        );
}
