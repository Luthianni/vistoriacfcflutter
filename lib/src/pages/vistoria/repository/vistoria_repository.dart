import 'package:vistoria_cfc/src/constants/endpoints.dart';
import 'package:vistoria_cfc/src/models/vistoria_model.dart';
import 'package:vistoria_cfc/src/pages/home/result/home_result.dart';
import 'package:vistoria_cfc/src/services/http_manager.dart';

class VistoriaRepository {
  final HttpManager _httpManager = HttpManager();

  Future<HomeResult<VistoriaModel>> getAllVistorias() async {
    final result = await _httpManager.restRequest(
      url: Endpoints.centroFormacaoCondutores,
      method: HttpMethods.get,
    );

    if (result['result'] != null) {
      List<VistoriaModel> data =
          (List<Map<String, dynamic>>.from(result['result']))
              .map(VistoriaModel.fromJson)
              .toList();

      return HomeResult<VistoriaModel>.success(data);
    } else {
      return HomeResult.error(
          'Ocorreu um erro inesperado ao recuperer as vistorias');
    }
  }
}
