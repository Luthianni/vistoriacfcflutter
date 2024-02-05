import 'package:dio/dio.dart';

abstract class HttpMethods {
  static const String post = 'POST';
  static const String get = 'GET';
  static const String put = 'PUT';
  static const String patch = 'PATCH';
  static const String delete = "DELETE";
}

class HttpManager {
  Future<Map> restRequest({
    required String url,
    required String method,
    Map? headers,
    Map? body,
    Map? token,
  }) async {
    final defaultHeaders = (headers?.cast<String, String>() ?? {})
      ..addAll({
        'content-type': 'application/json',
        if (token != null) 'authorization': 'Bearer $token',
      });

    Dio dio = Dio();
    dio.options.headers = defaultHeaders;

    try {
      print('Enviando requisição para $url');

      Response response = await dio.request(
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
