import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:vistoria_cfc/src/constants/endpoints.dart';
import 'package:vistoria_cfc/src/models/cfc_model.dart';
import 'package:vistoria_cfc/src/pages/cfc/result/cfc_result.dart';
import 'package:vistoria_cfc/src/services/http_manager.dart';

class CfcRepository {
  final HttpManager _httpManager = HttpManager();
  final Logger _logger = Logger();

  CfcResult handleCfcOrError(Map<dynamic, dynamic> result) {
    if (result.containsKey('result') && result['result'] != null) {
      return CfcResult.success(result['result']);
    } else {
      final errorMessage = result['message'] ?? 'Erro não encontrado!';
      _logger.d("Resposta do erro $result");
      return CfcResult.error(errorMessage);
    }
  }

  Future<CfcResult> cfcId(String token, String? id) async {
    try {
      String url = '/cfc';
      if (id != null) {
        url += '/$id';
      }

      final result = await _httpManager.restRequest(
        url: url,
        method: HttpMethods.get,
        headers: {'Authorization': 'Bearer $token'},
      );

      _logger.i('Resposta da request GET: $url');
      return handleCfcOrError(result);
    } on DioError catch (e) {
      _logger.e('Erro na requisição cfcId: ${e.message}');
      return CfcResult.error('Erro na requisição cfcId: ${e.message}');
    }
  }

  Future<CfcResult> createCfc(String token, CfcModel cfc) async {
    try {
      const url = Endpoints.centroFormacaoCondutores;

      final cfcData = cfc.toJson();
      _logger.i('Enviando dados para criação: $cfc');

      final result = await _httpManager.restRequest(
        url: url,
        method: HttpMethods.post,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
        body: cfcData,
      );

      _logger.i('Resposta da request POST: $url');
      return handleCfcOrError(result);
    } on DioError catch (e) {
      _logger.e('Erro na requisição createCfc: ${e.message}');
      return CfcResult.error('Erro na requisição createCfc: ${e.message}');
    }
  }
}
