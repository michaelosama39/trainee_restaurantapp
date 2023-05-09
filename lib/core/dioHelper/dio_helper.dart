import 'package:dio/dio.dart';

import '../net/api_url.dart';

class DioHelper {
  static Dio dioSingleton = Dio()..options.baseUrl = APIUrls.BASE_URL;

  static Future<Response<dynamic>> post(String path,
      {Map<String, dynamic>? body, Map<String, dynamic>? headers}) {
    dioSingleton.options.headers = headers;
    return dioSingleton.post(path,
        data: body,
        options: Options(
          validateStatus: (_) => true,
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ));
  }

  static Future<Response<dynamic>> get(String path,
      {Map<String, dynamic>? headers}) {
    dioSingleton.options.headers = headers;
    return dioSingleton.get(path);
  }
}
