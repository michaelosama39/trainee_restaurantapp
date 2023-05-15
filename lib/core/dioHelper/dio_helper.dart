import 'package:dio/dio.dart';
import 'package:trainee_restaurantapp/core/appStorage/app_storage.dart';

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

  static Future<Response<dynamic>> put(String path,
      {Map<String, dynamic>? body, Map<String, dynamic>? headers}) {
    dioSingleton.options.headers = headers;
    return dioSingleton.put(path,
        data: body,
        options: Options(
          validateStatus: (_) => true,
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ));
  }

  static Future<Response<dynamic>> get(String path,

      {Map<String, dynamic>? headers, Map<String, dynamic>? query}) {
    dioSingleton.options.headers = headers;
    return dioSingleton.get(path,
        queryParameters: query,
        options: Options(headers: {
      "Authorization" : "Bearer ${AppStorage.getUserInfo!.result!.accessToken}"
    }));
  }
}
