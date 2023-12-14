import 'package:vistoria_cfc/src/models/user_model.dart';
import 'package:vistoria_cfc/src/pages/auth/result/auth_result.dart';
import 'package:vistoria_cfc/src/services/http_manager.dart';
import 'package:vistoria_cfc/src/pages/auth/repository/auth_errors.dart'
    as authErros;
import 'package:vistoria_cfc/src/constants/endpoints.dart';

class AuthRepository {
  final HttpManager _httpManager = HttpManager();

  AuthResult handleUserOrError(Map<dynamic, dynamic> result) {
    if (result['result'] != null) {
      final user = UserModel.fromJson(result['result']);
      return AuthResult.success(user);
    } else {
      print("Resposta de erro: $result");
      return AuthResult.error(authErros.authErrorsString(result['error']));
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
        headers: {
          'Token': token,
        });

    return result['error'] == null;
  }

  Future<AuthResult> validateToken(String token) async {
    final result = await _httpManager.restRequest(
        url: Endpoints.validateToken,
        method: HttpMethods.post,
        headers: {
          'token': token,
        });

    return handleUserOrError(result);
  }

  Future<AuthResult> signIn(
      {required String username, required String password}) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.signin,
      method: HttpMethods.post,
      body: {
        'username': username,
        'password': password,
      },
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

  Future<void> resetPassword(String email) async {
    await _httpManager.restRequest(
      url: Endpoints.resetPassword,
      method: HttpMethods.post,
      body: {'email': email},
    );
  }
}
