import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:vistoria_cfc/src/models/user_model.dart';
import 'package:vistoria_cfc/src/pages/auth/result/auth_result.dart';
import 'package:vistoria_cfc/src/services/http_manager.dart';
import 'package:vistoria_cfc/src/pages/auth/repository/auth_errors.dart'
    as auth_errors;
import 'package:vistoria_cfc/src/constants/endpoints.dart';

class AuthRepository {
  final HttpManager _httpManager = HttpManager();
  final Logger logger = Logger();

  AuthResult handleUserOrError(Map<dynamic, dynamic> result) {
    if (result['result'] != null) {
      final user = UserModel.fromJson(result['result']);
      return AuthResult.success(user);
    } else {
      logger.d("Resposta do erro: $result");
      return AuthResult.error(auth_errors.authErrorsString(result['error']));
    }
  }

  Future<bool> changePassword({
    required String username,
    required String currentPassword,
    required String newPassword,
    required String token,
  }) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.changePassword,
      method: HttpMethods.post,
      body: {
        'username': username,
        'currentPassword': currentPassword,
        'newPassword': newPassword,
      },
      headers: {'Token': token},
    );

    return result['result'] != null;
  }

  Future<AuthResult> validateToken(String token) async {
    try {
      final result = await _httpManager.restRequest(
        url: Endpoints.validateToken,
        method: HttpMethods.post,
        headers: {'Authorization': 'Bearer $token'},
      );
      logger.i('Recebendo a requisição da $HttpManager(result)');
      return handleUserOrError(result);
    } on DioError catch (error) {
      if (error.response?.statusCode == 401) {
        // Token inválido, usuário não autenticado
        return AuthResult.error('Token inválido, faça login novamente.');
      } else {
        // Outro erro de resposta HTTP
        logger.e('Erro na requisição: ${error.message}');
        return AuthResult.error('Erro na requisição');
      }
    } catch (error) {
      // Erro desconhecido
      logger.e('Erro desconhecido: $error');
      return AuthResult.error('Erro desconhecido');
    }
  }

  Future<AuthResult> signIn({
    required String username,
    required String password,
  }) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.signin,
      method: HttpMethods.post,
      body: {'username': username, 'password': password},
    );

    return handleUserOrError(result);
  }

  Future<AuthResult> signUp(UserModel user) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.signup,
      method: HttpMethods.post,
      body: user.toJson(),
    );

    return handleUserOrError(result);
  }

  Future<void> resetPassword({String? email, UserModel? user}) async {
    await _httpManager.restRequest(
      url: Endpoints.resetPassword,
      method: HttpMethods.post,
      body: {'email': email ?? user?.email},
    );
  }
}
