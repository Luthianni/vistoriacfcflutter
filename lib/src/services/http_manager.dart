import 'dart:io';

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
          logger.i('Request: ${options.method} ${options.uri}');
          logger.i('Headers: ${options.headers}');
          logger.i('Data: ${options.data}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          logger.i('Response Status: ${response.statusCode}');
          logger.i('Response Data: ${response.data}');
          return handler.next(response);
        },
        onError: (DioError e, handler) {
          final StringBuffer errorDetails = StringBuffer();
          errorDetails.writeln('=== Erro Detalhado ===');
          errorDetails.writeln('URL: ${e.requestOptions.uri}');
          errorDetails.writeln('Método: ${e.requestOptions.method}');
          errorDetails.writeln('Status Code: ${e.response?.statusCode}');
          errorDetails.writeln('Mensagem: ${e.message}');
          errorDetails.writeln('Dados da Resposta: ${e.response?.data}');
          errorDetails.writeln('Headers da Requisição: ${e.requestOptions.headers}');
          
          logger.e(errorDetails.toString(), error: e.error, stackTrace: e.stackTrace);
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
    try {
      final defaultHeaders = {
        ...?headers?.cast<String, String>(),
        'content-type': 'application/json',
        if (token?.isNotEmpty ?? false) 'Authorization': 'Bearer $token',
      };

      logger.i('Iniciando requisição para $url');
      logger.i('Headers: $defaultHeaders');
      logger.i('Body: $body');

      final response = await _dio.request(
        url,
        options: Options(
          headers: defaultHeaders,
          method: method,
          validateStatus: (status) {
            return status != null && status < 500;
          },
        ),
        data: body,
      );

      if (response.statusCode == 401) {
        logger.w('Token inválido ou expirado');
        return {'error': 'Token inválido ou expirado'};
      }

      if (response.statusCode != 200 && response.statusCode != 201) {
        logger.e('Erro na requisição: Status ${response.statusCode}');
        logger.e('Resposta de erro: ${response.data}');
        return {
          'error': response.data['message'] ?? 'Erro desconhecido',
          'statusCode': response.statusCode,
        };
      }

      logger.i('Requisição bem-sucedida: ${response.data}');
      return response.data;
    } on DioError catch (error) {
      final errorMessage = _handleDioError(error);
      logger.e('Erro Dio: $errorMessage');
      return {'error': errorMessage};
    } catch (error) {
      logger.e('Erro não esperado: $error');
      return {'error': 'Ocorreu um erro inesperado'};
    }
  }

  String _handleDioError(DioError error) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
        return 'Tempo de conexão esgotado';
      case DioErrorType.sendTimeout:
        return 'Tempo de envio esgotado';
      case DioErrorType.receiveTimeout:
        return 'Tempo de recebimento esgotado';
      case DioErrorType.response:
        return _handleResponseError(error.response);
      case DioErrorType.cancel:
        return 'Requisição cancelada';
      case DioErrorType.other:
        if (error.error is SocketException) {
          return 'Sem conexão com a internet';
        }
        return 'Erro inesperado na conexão';
    }
  }

  String _handleResponseError(Response? response) {
    if (response == null) return 'Erro na resposta do servidor';
    
    switch (response.statusCode) {
      case 400:
        return 'Requisição inválida';
      case 401:
        return 'Não autorizado';
      case 403:
        return 'Acesso negado';
      case 404:
        return 'Recurso não encontrado';
      case 500:
        return 'Erro interno do servidor';
      default:
        return 'Erro ${response.statusCode}: ${response.data['message'] ?? 'Erro desconhecido'}';
    }
  }

  void dispose() {
    _dio.close();
  }
}