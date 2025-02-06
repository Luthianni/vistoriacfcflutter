import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:vistoria_cfc/src/models/user_model.dart';
import 'package:vistoria_cfc/src/pages/auth/result/auth_result.dart';
import 'package:vistoria_cfc/src/services/http_manager.dart';
import 'package:vistoria_cfc/src/constants/endpoints.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

class AuthRepository {
  final HttpManager _httpManager = HttpManager();
  final Logger logger = Logger();

  void _showSnackbar(
      {required BuildContext context,
      required String message,
      required ContentType contentType}) {
    if (!context.mounted) return;

    final snackBar = SnackBar(
      content: AwesomeSnackbarContent(
        title: contentType == ContentType.failure ? 'Erro' : 'Sucesso',
        message: message,
        contentType: contentType,
      ),
      backgroundColor: Colors.transparent,
      behavior: SnackBarBehavior.floating,
      elevation: 0,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  AuthResult _handleUserOrError(
      {required Map<dynamic, dynamic> response,
      required BuildContext context}) {
    logger.d("Processando resposta: $response");

    if (response['error'] != null) {
      final error = response['error'];
      final String errorMessages =
          error is String ? error : error['message'] ?? 'Erro desconhecido';
      logger.e("Erro encontrado: $errorMessages");
      _showSnackbar(context: context, message: errorMessages, contentType: ContentType.failure);
      return AuthResult.error(errorMessages);
    }

    try {
      if (response['result'] != null) {
        final result = response['result'] as Map<dynamic, dynamic>;
        final user = UserModel(
          id: result['id'].toString(),
          username: result['username'],
          token: result['token'],
        );
        _showSnackbar(context: context, message: 'Login realizado com sucesso', contentType: ContentType.success);
        return AuthResult.success(user);
      } else {
        logger.w("Resposta sem dados de usuário: $response");
        _showSnackbar(
            context: context,
            message: 'Dados do usuário não encontrados na resposta',
            contentType: ContentType.failure);
        return AuthResult.error('Dados do usuário não encontrados na resposta');
      }
    } catch (e) {
      logger.e("Erro ao processar dados do usuário: $e");
      _showSnackbar(
          context: context,
          message: 'Erro ao processar dados do usuário',
          contentType: ContentType.failure);
      return AuthResult.error('Erro ao processar dados do usuário');
    }
  }

  Future<AuthResult> validateToken({
    required String token,
    required String username,
    required String password,
    required BuildContext context,
  }) async {
    try {
      logger.i('Iniciando validação do token');

      final result = await _httpManager.restRequest(
        url: Endpoints.validateToken,
        method: HttpMethods.post,
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: {
          'username': username,
          'password': password,
        },
      );

      logger.i('Resposta da validação: $result');

      return _handleUserOrError(response: result, context: context);
    } on DioError catch (error) {
      logger.e('''
        Erro na validação do token:
        Status Code: ${error.response?.statusCode}
        Data: ${error.response?.data}
        ''');

      String errorMessage;
      if (error.response?.statusCode == 401) {
        errorMessage = 'Token inválido ou expirado';
      } else if (error.response?.statusCode == 400) {
        final errorData = error.response?.data;
        errorMessage = errorData is Map
            ? errorData['error']?.toString() ?? 'Erro na validação'
            : 'Erro na validação';
      } else if (error.response?.statusCode == 500) {
        errorMessage = 'Erro interno do servidor';
      } else {
        errorMessage = 'Erro na validação do token';
      }

      _showSnackbar(context: context, message: errorMessage, contentType: ContentType.failure);
      return AuthResult.error(errorMessage);
    } catch (error) {
      logger.e('Erro não esperado: $error');
      _showSnackbar(context: context, message: 'Erro inesperado na validação do token', contentType: ContentType.failure);
      return AuthResult.error('Erro inesperado na validação do token');
    }
  }

  Future<AuthResult> signIn({
    required String username,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final result = await _httpManager.restRequest(
        url: Endpoints.signin,
        method: HttpMethods.post,
        body: {
          'username': username,
          'password': password,
        },
      );

      return _handleUserOrError(response: result, context: context);
    } catch (error) {
      logger.e('Erro no login: $error');
      _showSnackbar(context:context, message: 'Erro ao realizar login', contentType: ContentType.failure);
      return AuthResult.error('Erro ao realizar login');
    }
  }

  Future<AuthResult> signUp({
    required UserModel user,
    required BuildContext context,
  }) async {
    try {
      final result = await _httpManager.restRequest(
        url: Endpoints.signup,
        method: HttpMethods.post,
        body: {
          'username': user.username,
          'password': user.password,
        },
      );

      return _handleUserOrError(response: result, context: context);
    } catch (error) {
      logger.e('Erro no registro: $error');
      if (error is DioError && error.response?.statusCode == 400) {
        _showSnackbar(context: context, message: 'Dados de registro inválidos', contentType: ContentType.failure);
        return AuthResult.error('Dados de registro inválidos');
      }
      _showSnackbar(context: context, message: 'Erro ao realizar registro', contentType: ContentType.failure);
      return AuthResult.error('Erro ao realizar registro');
    }
  }

  Future<bool> changePassword({
    required String username,
    required String currentPassword,
    required String newPassword,
    required String token,
    required BuildContext context,
  }) async {
    try {
      final result = await _httpManager.restRequest(
        url: Endpoints.changePassword,
        method: HttpMethods.post,
        body: {
          'username': username,
          'currentPassword': currentPassword,
          'newPassword': newPassword,
        },
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (result['result'] != null) {
        _showSnackbar(context: context, message: 'Senha alterada com sucesso', contentType: ContentType.success);
        return true;
      } else {
        _showSnackbar(context: context, message: 'Erro ao alterar senha', contentType: ContentType.failure);
        return false;
      }
    } catch (e) {
      logger.e('Erro na mudança de senha: $e');
      _showSnackbar(context: context, message: 'Erro ao alterar senha', contentType: ContentType.failure);
      return false;
    }
  }
}
