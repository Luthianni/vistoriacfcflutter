import 'package:get/get.dart';
import 'package:logger/logger.dart'; // Adicione esta importação
import 'package:vistoria_cfc/src/constants/endpoints.dart';
import 'package:vistoria_cfc/src/constants/storage_keys.dart';
import 'package:vistoria_cfc/src/models/user_model.dart';
import 'package:vistoria_cfc/src/pages/auth/repository/auth_repository.dart';
import 'package:vistoria_cfc/src/services/utils_services.dart';
import 'package:vistoria_cfc/src/pages/auth/result/auth_result.dart';
import 'package:vistoria_cfc/src/pages_routes/app_pages.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
  final authRepository = AuthRepository();
  final utilsServices = UtilsServices();
  UserModel user = UserModel();

  final logger = Logger();

  @override
  void onInit() {
    super.onInit();
    validateToken();
  }

  Future<void> validateToken() async {
    String? token = await utilsServices.getLocalData(key: StorageKeys.token);

    if (token == null) {
      Get.offAllNamed(PagesRoutes.signInRoute);
      return;
    }

    logger.i('Requisição bem-sucedida: $token');

    AuthResult result = await authRepository.validateToken(token);

    result.when(
      success: (user) {
        utilsServices.saveLocalData(key: StorageKeys.token, data: user.token!);
        this.user = user;

        saveTokenAndProceedToBase();
      },
      error: (message) {
        signOut();
      },
    );
  }

  Future<void> signIn({
    required String username,
    required String password,
  }) async {
    isLoading.value = true;

    AuthResult result =
        await authRepository.signIn(username: username, password: password);

    isLoading.value = false;

    result.when(
      success: (user) {
        this.user = user;

        saveTokenAndProceedToBase();
      },
      error: (message) {
        utilsServices.showToast(
          message: message,
          isError: true,
        );
      },
    );
  }

  // Future<void> changePassword({
  //   required String currentPassword,
  //   required String newPassword,
  // }) async {
  //   isLoading.value = true;

  //   final result = await authRepository.changePassword(
  //     username: user.username!,
  //     currentPassword: currentPassword,
  //     newPassword: newPassword,
  //     token: user.token!,
  //   );

  //   isLoading.value = false;

  //   if (result) {
  //     utilsServices.showToast(
  //       message: 'A senha foi atualizada com sucesso!',
  //     );

  //     signOut();
  //   } else {
  //     utilsServices.showToast(
  //       message: 'A senha atual está incorreta',
  //       isError: true,
  //     );
  //   }
  // }

  // Future<void> resetPassword(String email) async {
  //   await authRepository.resetPassword(email: email);
  // }

  Future<void> signOut() async {
    user = UserModel();
    await utilsServices.removeLocalData(key: StorageKeys.token);
    Get.offAllNamed(PagesRoutes.signInRoute);
  }

  void saveTokenAndProceedToBase() {
    utilsServices.saveLocalData(key: StorageKeys.token, data: user.token!);
    if (user.id != null) {
      String userId = user.id.toString();
      utilsServices.saveLocalData(key: StorageKeys.id, data: userId);
    }
    Get.offAllNamed(PagesRoutes.baseRoute);
  }

  Future<void> signUp() async {
    isLoading.value = true;

    AuthResult result = await authRepository.signUp(user);

    isLoading.value = false;

    result.when(
      success: (user) {
        this.user = user;
        saveTokenAndProceedToBase();
      },
      error: (message) {
        utilsServices.showToast(
          message: message,
          isError: true,
        );
      },
    );
  }

  Future<void> userId() async {
    String? token = await utilsServices.getLocalData(key: StorageKeys.token);

    if (token == null) {
      Get.offAllNamed(PagesRoutes.baseRoute);
      return;
    }

    logger.i('Token obtido com sucesso: $token');

    String? id = await utilsServices.getLocalData(key: StorageKeys.id);
    if (id == null) {
      return;
    }

    logger.i('ID do usuário obtido: $id');

    String userIdUrl = '$baseUrl/api/v1/usuarios/$id';

    AuthResult authResult = await authRepository.userId(token, id);

    authResult.when(
      success: (user) {
        this.user = user;
        logger.i('Token válido e ID de de usuário existente !!');
      },
      error: (message) {
        utilsServices.showToast(
          message: message,
          isError: true,
        );
        logger.i(user);
        Get.offAllNamed(PagesRoutes.baseRoute);
      },
    );
  }
}
