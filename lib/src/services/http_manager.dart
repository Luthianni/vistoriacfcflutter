import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

abstract class HttpMethods {
  static const String post = 'POST';
  static const String get = 'GET';
  static const String put = 'PUT';
  static const String patch = 'PATCH';
  static const String delete = "DELETE";
}

class HttpManager {
  late Dio _dio;
  final logger = Logger();

  HttpManager() {
    _initializeDio();
  }

  Future<void> _initializeDio() async {
    _dio = Dio();
  }

  Future<Map<String, dynamic>> restRequest({
    required String url,
    required String method,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    String? token,
  }) async {
    final defaultHeaders = (headers?.cast<String, String>() ?? {})
      ..addAll({
        'content-type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      });

    try {
      logger.i('Enviando requisição para $url');

      Response response = await _dio.request(
        url,
        options: Options(
          headers: defaultHeaders,
          method: method,
        ),
        data: body,
      );

      logger.i('Requisição bem-sucedida: ${response.data}');

      return response.data;
    } on DioError catch (error) {
      logger.e('Erro na requisição: ${error.message}');
      return Future.value(error.response?.data ?? {});
    } catch (error) {
      logger.e('Erro desconhecido: $error');
      return {};
    }
  }

  void dispose() {
    _dio.close();
  }
}
