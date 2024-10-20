import 'package:dio/dio.dart';
import 'package:movieapp/services/api/interceptors.dart';

class ApiService {
  final Dio dio;
  ApiService()
      : dio = Dio(
          BaseOptions(
              baseUrl: "https://api.jsonbin.io/v3/b",
              receiveTimeout: Duration(milliseconds: 30000),
              sendTimeout: Duration(milliseconds: 30000),
              headers: {}),
        )..interceptors.add(CustomInterceptors());

  Future<Response> getRequest(String path, [bool isAuth = false]) async {
    if (isAuth) {
      return dio.get(
        path,
        options: Options(headers: {
          "X-Access-Key":
              "\$2a\$10\$mWuvs2w8suWQEJbULlwTWOIAq3v9FQW.sHPZ.TtedGzw9fMst0gbW"
        }),
      );
    } else {
      return dio.get(path);
    }
  }

  Future<Response> postRequest(String path,
      {bool isAuth = true, dynamic body}) async {
    if (isAuth) {
      return dio.get(path,
          data: body, options: Options(headers: {"Authorization": ""}));
    } else {
      return dio.get(path, data: body);
    }
  }
}
