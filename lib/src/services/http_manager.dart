import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

abstract class HttpMethods {
  static const String post = 'POST';
  static const String get = 'GET';
  static const String put = 'PUT';
  static const String patch = 'PATCH';
  static const String delete = 'DELETE';
}

class HttpManager {
  late final Dio _dio;
  final logger = Logger();

  HttpManager() : _dio = Dio() {
    _initializeInterceptors();
  }

  void _initializeInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          logger.i('Interceptador: Antes da requisição - ${options.uri}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          logger.i(
              'Interceptador: Após a resposta - ${response.requestOptions.uri}');
          return handler.next(response);
        },
        onError: (DioError e, handler) {
          logger.e('Interceptador de Erro: ${e.message}');
          return handler.next(e);
        },
      ),
    );
  }

  Future<Map<String, dynamic>> restRequest({
    required String url,
    required String method,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    String? token,
  }) async {
    final defaultHeaders = {
      ...?headers?.cast<String, String>(),
      'content-type': 'application/json',
      if (token?.isNotEmpty ?? false) 'Authorization': 'Bearer $token',
    };

    try {
      logger.w('Enviando requisição para $url');
      final response = await _dio.request(
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
      return error.response?.data ?? {};
    } catch (error) {
      logger.e('Erro desconhecido: $error');
      return {};
    }
  }

  void dispose() {
    _dio.close();
  }
}
