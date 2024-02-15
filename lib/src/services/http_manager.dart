import 'package:dio/dio.dart';

abstract class HttpMethods {
  static const String post = 'POST';
  static const String get = 'GET';
  static const String put = 'PUT';
  static const String patch = 'PATCH';
  static const String delete = "DELETE";
}

class HttpManager {
  late Dio _dio;

  HttpManager() {
    _dio = Dio();
  }

  Future<Map> restRequest({
    required String url,
    required String method,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    Map? token,
  }) async {
    final defaultHeaders = (headers?.cast<String, String>() ?? {})
      ..addAll({
        'content-type': 'application/json',
        if (token != null) 'authorization': 'Bearer $token',
      });

    try {
      print('Enviando requisição para $url');

      Response response = await _dio.request(
        url,
        options: Options(
          headers: defaultHeaders,
          method: method,
        ),
        data: body,
      );

      print('Requisição bem-sucedida: ${response.data}');

      return response.data;
    } on DioError catch (error) {
      print('Erro na requisição: ${error.message}');
      return error.response?.data ?? {};
    } catch (error) {
      print('Erro desconhecido: $error');
      return {};
    }
  }
}
