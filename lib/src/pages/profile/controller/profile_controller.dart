import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:vistoria_cfc/src/constants/storage_keys.dart';
import 'package:vistoria_cfc/src/models/profile_model.dart';
import 'package:vistoria_cfc/src/pages/auth/repository/auth_repository.dart';
import 'package:vistoria_cfc/src/pages/profile/repository/profile_repository.dart';
import 'package:vistoria_cfc/src/pages/profile/result/profile_result.dart';
import 'package:vistoria_cfc/src/pages_routes/app_pages.dart';
import 'package:vistoria_cfc/src/services/utils_services.dart';

class ProfileController extends GetxController {
  RxBool isLoading = false.obs;
  final ProfileRepository _profileRepository = ProfileRepository();
  final authRepository = AuthRepository();
  final utilsServices = UtilsServices();
  Rx<ProfileModel> profile = ProfileModel().obs; // Make profile observable

  final logger = Logger();

  @override
  void onInit() {
    super.onInit();
    profileId();
  }

  Future<void> profileId() async {
    String? token = await utilsServices.getLocalData(key: StorageKeys.token);
    String? id = await utilsServices.getLocalData(key: StorageKeys.id);

    if (token == null && id == null) {
      Get.offAllNamed(PagesRoutes.baseRoute);
      return;
    }

    logger.i('Requisição bem sucedida: $token, $id');

    try {
      ProfileResult result = await _profileRepository.profileId(token!, id);
      if (result is Success) {
        // Sucesso: atribuir o perfil extraído do resultado
        profile.value = result.prof;
        logger.i('Perfil encontrado: ${profile.value}');
        
        // Chamar o método loadProfileData após o perfil ser carregado com sucesso
        await loadProfileData();
      } else if (result is Error) {
        // Trate o caso em que ocorreu um erro
        logger.e('Erro ao buscar perfil: ${result.message}');
      } else {
        // Trate o caso em que o resultado não é do tipo esperado
        logger.e('Erro: resultado inesperado');
      }
    } catch (e) {
      // Trate qualquer exceção não tratada adequadamente aqui
      logger.e('Erro ao buscar perfil: $e');
    }
  }

  Future<void> loadProfileData() async {
    // Implement your logic here
  }
}