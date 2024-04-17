import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:vistoria_cfc/src/constants/endpoints.dart';
import 'package:vistoria_cfc/src/models/profile_model.dart';
import 'package:vistoria_cfc/src/pages/profile/result/profile_result.dart';
import 'package:vistoria_cfc/src/services/http_manager.dart';
import 'package:vistoria_cfc/src/pages/profile/repository/profile_errors.dart'
    as profile_errors;

class ProfileRepository {
  final HttpManager _httpManager = HttpManager();
  final Logger logger = Logger();

  ProfileResult handleProfileOrError(Map<dynamic, dynamic> result) {
    if (result.containsKey('result') && result['result'] != null) {
      final prof = ProfileModel.fromJson(result['result']);
      return ProfileResult.success(prof);
    } else {
      final errorMessage = result['message'] ?? 'Erro não encontrado!';
      logger.d("Resposta do erro $result");
      return ProfileResult.error(
          profile_errors.profileErrorsString(errorMessage));
    }
  }

  Future<ProfileResult> profileId(String token, String? id) async {
    try {
      String url = Endpoints.profileId;

      if (id != null) {
        url += '/$id';
      }

      final result = await _httpManager.restRequest(
        url: url,
        method: HttpMethods.get,
        headers: {'Authorization': 'Bearer $token'},
      );
      logger.i('Resposta da request : $url');
      // Verifique se o resultado é uma instância de Map<String, dynamic>
      if (result is Map<String, dynamic>) {
        return handleProfileOrError(result);
      } else {
        // Trate o caso em que o resultado não é do tipo esperado
        return ProfileResult.error('Erro: resposta inválida');
      }
    } on DioError catch (error) {
      return ProfileResult.error('Erro na requisição profileId');
    }
  }
}
