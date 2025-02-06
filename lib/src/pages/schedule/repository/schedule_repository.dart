import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:vistoria_cfc/src/constants/endpoints.dart';
import 'package:vistoria_cfc/src/models/schedule_model.dart';
import 'package:vistoria_cfc/src/pages/schedule/result/schedule_result.dart';
import 'package:vistoria_cfc/src/services/http_manager.dart';

class ScheduleRepository {
  final HttpManager _httpManager = HttpManager();
  final logger = Logger();

  ScheduleResult handleScheduleOrError(Map<dynamic, dynamic> result) {
    if (result.containsKey('result') && result['result'] != null) {
      final schedule = ScheduleModel.fromJson(result['result']);
      return ScheduleResult.success(schedule);
    } else {
      final errorMessage = result['message'] ?? 'Erro não encontrado!';
      logger.d("Resposta do erro $result");
      return ScheduleResult.error(errorMessage);
    }
  }

 Future<ScheduleResult> scheduleId(String token, String? id) async {
    try {
      String url = Endpoints.agendamento;
      if (id != null) {
        url += '/$id';
      }

      final result = await _httpManager.restRequest(
        url: url,
        method: HttpMethods.get, // Changed to GET since we're fetching data
        headers: {'Authorization': 'Bearer $token'},
      );
      
      logger.i('Resposta da request GET: $url');
      return handleScheduleOrError(result);
    } on DioError catch (e) {
      logger.e('Erro na requisição scheduleId: ${e.message}');
      return ScheduleResult.error('Erro na requisição scheduleId: ${e.message}');
    }
  }

  Future<ScheduleResult> createSchedule(String token, ScheduleModel schedule) async {
    try {
      const url = Endpoints.agendamento;
      
      // Prepare the schedule data
      final scheduleData = schedule.toJson();
      logger.i('Enviando dados para criação: $scheduleData');

      final result = await _httpManager.restRequest(
        url: url,
        method: HttpMethods.post,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
        body: scheduleData,
      );
      
      logger.i('Resposta da request POST: $url');
      return handleScheduleOrError(result);
    } on DioError catch (e) {
      logger.e('Erro na requisição createSchedule: ${e.message}');
      return ScheduleResult.error('Erro na requisição createSchedule: ${e.message}');
    }
  }
}