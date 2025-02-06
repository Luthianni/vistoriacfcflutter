import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:vistoria_cfc/src/constants/storage_keys.dart';
import 'package:vistoria_cfc/src/models/schedule_model.dart';
import 'package:vistoria_cfc/src/pages/auth/repository/auth_repository.dart';
import 'package:vistoria_cfc/src/pages/schedule/repository/schedule_repository.dart';
import 'package:vistoria_cfc/src/pages/schedule/result/schedule_result.dart';
import 'package:vistoria_cfc/src/pages_routes/app_pages.dart';
import 'package:vistoria_cfc/src/services/utils_services.dart';

class ScheduleController extends GetxController {
  RxBool isLoading = false.obs;
  final ScheduleRepository _scheduleRepository = ScheduleRepository();
  final authRepository = AuthRepository();
  final utilsServices = UtilsServices();
  final logger = Logger();

  Rx<ScheduleModel> schedule = ScheduleModel(
    id: null,
    centroDeFormacao: '',
    fantasia: '',
    situacao: '',
    cnpj: '',
    email: '',
    cep: '',
    endereco: '',
    numero: '',
    bairro: '',
    cidade: '',
    estado: '',
    telefone: '',
    tipo: '',
    data: DateTime.now(),
  ).obs; // Make schedule observable

  

  @override
  void onInit() {
    super.onInit();
    scheduleId();
  }

  Future<void> scheduleId() async {
    String? token = await utilsServices.getLocalData(key: StorageKeys.token);
    String? id = await utilsServices.getLocalData(key: StorageKeys.id);

    if (token == null || id == null) {
      Get.offAllNamed(PagesRoutes.baseRoute);
      return;
    }

    logger.i('Requisição bem sucedida: $token, $id');

    try {
      isLoading.value = true;
      ScheduleResult result = await _scheduleRepository.scheduleId(token, id);
      isLoading.value = false;

      if (result is Success) {
        // Sucesso: atribuir o agendamento extraído do resultado
        schedule.value = result.sch;
        logger.i('Agendamento encontrado: ${schedule.value}');

        // Chamar o método loadScheduleData após o agendamento ser carregado com sucesso
        await loadScheduleData();
      } else if (result is Error) {
        // Trate o caso em que ocorreu um erro
        logger.e('Erro ao buscar agendamento: ${result.message}');
        Get.snackbar(
          'Erro',
          'Erro ao buscar agendamento: ${result.message}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else {
        // Trate o caso em que o resultado não é do tipo esperado
        logger.e('Erro: resultado inesperado');
        Get.snackbar(
          'Erro',
          'Erro: resultado inesperado',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      isLoading.value = false;
      // Trate qualquer exceção não tratada adequadamente aqui
      logger.e('Erro ao buscar agendamento: $e');
      Get.snackbar(
        'Erro',
        'Erro ao buscar agendamento. Tente novamente mais tarde.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> createSchedule(ScheduleModel agendamento) async {
  String? token = await utilsServices.getLocalData(key: StorageKeys.token);

  if (token == null) {
    Get.offAllNamed(PagesRoutes.baseRoute);
    return;
  }

  logger.i('Enviando agendamento: $agendamento');

   
  
  try {
    isLoading.value = true;
    final result = await _scheduleRepository.createSchedule(token, agendamento);
    isLoading.value = false;

    if (result is Success) {
      logger.i('Agendamento enviado com sucesso');
      Get.snackbar(
        'Sucesso',
        'Agendamento enviado com sucesso',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } else if (result is Error) {
      logger.e('Erro ao enviar agendamento: ${result.message}');
      Get.snackbar(
        'Erro',
        'Erro ao enviar agendamento: ${result.message}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else {
      logger.e('Erro: resultado inesperado');
      Get.snackbar(
        'Erro',
        'Erro: resultado inesperado',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  } catch (e) {
    isLoading.value = false;
    logger.e('Erro ao enviar agendamento: $e');
    Get.snackbar(
      'Erro',
      'Erro ao enviar agendamento. Tente novamente mais tarde.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }
}


  Future<void> loadScheduleData() async {
  
    logger.i('Carregando dados adicionais do agendamento...');
  }
}