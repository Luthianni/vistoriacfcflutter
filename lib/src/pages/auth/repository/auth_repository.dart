import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:vistoria_cfc/src/models/user_model.dart';
import 'package:vistoria_cfc/src/pages/auth/result/auth_result.dart';
import 'package:vistoria_cfc/src/services/http_manager.dart';
import 'package:vistoria_cfc/src/constants/endpoints.dart';

class AuthRepository {
  final HttpManager _httpManager = HttpManager();
  final Logger logger = Logger();

  AuthResult handleUserOrError(Map<dynamic, dynamic> response) {
    logger.d("Processando resposta: $response");
    
    if (response['error'] != null) {
      final error = response['error'];
      final String errorMessage = error is String ? error : error['message'] ?? 'Erro desconhecido';
      logger.e("Erro encontrado: $errorMessage");
      return AuthResult.error(errorMessage);
    }
    
    try {
      if (response['result'] != null) {
        final result = response['result'] as Map<dynamic, dynamic>;
        final user = UserModel(
          id: result['id'].toString(),
          username: result['username'],
          token: result['token'],
        );
        return AuthResult.success(user);
      } else {
        logger.w("Resposta sem dados de usuário: $response");
        return AuthResult.error('Dados do usuário não encontrados na resposta');
      }
    } catch (e) {
      logger.e("Erro ao processar dados do usuário: $e");
      return AuthResult.error('Erro ao processar dados do usuário');
    }
  }

 Future<AuthResult> validateToken({
  required String token,
  required String username,
  required String password,
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
    
    return handleUserOrError(result);
  } on DioError catch (error) {
    logger.e('''
      Erro na validação do token:
      Status Code: ${error.response?.statusCode}
      Data: ${error.response?.data}
      ''');

    if (error.response?.statusCode == 401) {
      return AuthResult.error('Token inválido ou expirado');
    } else if (error.response?.statusCode == 400) {
      final errorData = error.response?.data;
      final errorMessage = errorData is Map ? 
          errorData['error']?.toString() ?? 'Erro na validação' :
          'Erro na validação';
      return AuthResult.error(errorMessage);
    } else if (error.response?.statusCode == 500) {
      return AuthResult.error('Erro interno do servidor');
    }
    
    return AuthResult.error('Erro na validação do token');
  } catch (error) {
    logger.e('Erro não esperado: $error');
    return AuthResult.error('Erro inesperado na validação do token');
  }
}

  Future<AuthResult> signIn({
    required String username,
    required String password,
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

      return handleUserOrError(result);
    } catch (error) {
      logger.e('Erro no login: $error');
      if (error is DioError && error.response?.statusCode == 400) {
        return AuthResult.error('Credenciais inválidas');
      }
      return AuthResult.error('Erro ao realizar login');
    }
  }

  Future<AuthResult> signUp(UserModel user) async {
    try {
      final result = await _httpManager.restRequest(
        url: Endpoints.signup,
        method: HttpMethods.post,
        body: {
          'username': user.username,
          'password': user.password,
          // Add other user fields as necessary
        },
      );

      return handleUserOrError(result);
    } catch (error) {
      logger.e('Erro no registro: $error');
      if (error is DioError && error.response?.statusCode == 400) {
        return AuthResult.error('Dados de registro inválidos');
      }
      return AuthResult.error('Erro ao realizar registro');
    }
  }

  Future<bool> changePassword({
    required String username,
    required String currentPassword,
    required String newPassword,
    required String token,
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

      return result['result'] != null;
    } catch (e) {
      logger.e('Erro na mudança de senha: $e');
      return false;
    }
  }
}