import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:vistoria_cfc/src/constants/storage_keys.dart';
import 'package:vistoria_cfc/src/models/cfc_model.dart';
import 'package:vistoria_cfc/src/pages/auth/repository/auth_repository.dart';
import 'package:vistoria_cfc/src/pages/cfc/repository/cfc_repository.dart';
import 'package:vistoria_cfc/src/pages/cfc/result/cfc_result.dart';
import 'package:vistoria_cfc/src/pages_routes/app_pages.dart';
import 'package:vistoria_cfc/src/services/utils_services.dart';

class CfcController extends GetxController {
  RxBool isLoading = false.obs;
  final CfcRepository _cfcRepository = CfcRepository();
  final authRepository = AuthRepository();
  final utilsServices = UtilsServices();
  final logger = Logger();

  Rx<CfcModel> cfc = CfcModel(
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
  ).obs; // Make cfc observable

  @override
  void onInit() {
    super.onInit();
    cfcId();
  }

  Future<void> cfcId() async {
    String? token = await utilsServices.getLocalData(key: StorageKeys.token);
    String? id = await utilsServices.getLocalData(key: StorageKeys.id);

    if (token == null || id == null) {
      Get.offAllNamed(PagesRoutes.baseRoute);
      return;
    }

    logger.i('Requisição bem sucedida: $token, $id');

    try {
      isLoading.value = true;
      CfcResult result = await _cfcRepository.cfcId(token, id);
      isLoading.value = false;

      if (result is Success) {
        cfc.value = result.cfc;
        logger.i('Dados do CFC: ${cfc.value}');

        await loadCfcData();
      } else if (result is Error) {
        logger.e('Erro ao buscar dados do CFC: ${result.message}');
        Get.snackbar(
          'Erro',
          'Erro ao buscar agendamento: ${result.message}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      isLoading.value = false;
      logger.e('Erro ao buscar dados do CFC: $e');
    }
  }

  Future<void> createCfc(CfcModel cfc) async {
    String? token = await utilsServices.getLocalData(key: StorageKeys.token);

    if (token == null) {
      Get.offAllNamed(PagesRoutes.baseRoute);
      return;
    }

    logger.i('Enviando Centro de Formação: $cfc');

    try {
      isLoading.value = true;
      CfcResult result = await _cfcRepository.createCfc(token, cfc);
      isLoading.value = false;

      if (result is Success) {
        logger.i('CFC cadastrado com sucesso: ${result.cfc}');
        Get.snackbar(
          'Sucesso',
          'CFC cadastrado com sucesso',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else if (result is Error) {
        logger.e('Erro ao cadastrar CFC: ${result.message}');
        Get.snackbar(
          'Erro',
          'Erro ao criar CFC: ${result.message}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      isLoading.value = false;
      logger.e('Erro ao criar CFC: $e');
      Get.snackbar(
          'Error', 'Erro ao cadastrar CFC. Tente novamente mais tarde.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  Future<void> loadCfcData() async {
    String? token = await utilsServices.getLocalData(key: StorageKeys.token);
    String? id = await utilsServices.getLocalData(key: StorageKeys.id);

    if (token == null || id == null) {
      Get.offAllNamed(PagesRoutes.baseRoute);
      return;
    }

    logger.i('Requisição bem sucedida: $token, $id');

    try {
      isLoading.value = true;
      CfcResult result = await _cfcRepository.cfcId(token, id);
      isLoading.value = false;

      if (result is Success) {
        cfc.value = result.cfc;
        logger.i('Dados do CFC: ${cfc.value}');
      } else if (result is Error) {
        logger.e('Erro ao buscar dados do CFC: ${result.message}');
        Get.snackbar(
          'Erro',
          'Erro ao buscar agendamento: ${result.message}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      isLoading.value = false;
      logger.e('Erro ao buscar dados do CFC: $e');
    }
  }
}
