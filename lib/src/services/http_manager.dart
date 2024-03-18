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
          String errorMessage;
          dynamic originalError;
          StackTrace? stackTrace;

          if (e.response != null) {
            // Se houver uma resposta da solicitação, use o status code da resposta.
            errorMessage =
                'Erro de solicitação com código de status ${e.response?.statusCode}: ${e.message}';
            originalError = e.error;
            stackTrace = e.stackTrace;
          } else {
            // Se não houver resposta, é provavelmente um erro de conexão.
            errorMessage = 'Erro de conexão: ${e.message}';
            originalError = e.error;
            stackTrace = StackTrace.fromString('');
          }

          // Log do erro.
          logger.e(errorMessage, error: originalError, stackTrace: stackTrace);

          // Aqui você pode realizar tratamento específico para diferentes tipos de erro,
          // como reenviar a solicitação, mostrar uma mensagem de erro para o usuário, etc.

          // Retornar o erro para que ele continue sendo propagado.
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
