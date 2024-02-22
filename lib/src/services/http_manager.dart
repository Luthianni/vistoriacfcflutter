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

  void _initializeDio() {
    // Inicialize o Dio
    _dio = Dio();

    // Adicione interceptadores ao Dio
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Interceptador executado antes da requisição ser enviada
          logger.i('Interceptador: Antes da requisição - ${options.uri}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          // Interceptador executado após a resposta ser recebida
          logger.i(
              'Interceptador: Após a resposta - ${response.requestOptions.uri}');
          return handler.next(response);
        },
        onError: (DioError e, handler) {
          // Interceptador executado em caso de erro
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
    final defaultHeaders = (headers?.cast<String, String>() ?? {})
      ..addAll({
        'content-type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      });

    try {
      logger.w('Enviando requisição para $url');

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
