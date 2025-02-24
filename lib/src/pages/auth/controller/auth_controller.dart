import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:vistoria_cfc/src/constants/storage_keys.dart';
import 'package:vistoria_cfc/src/models/user_model.dart';
import 'package:vistoria_cfc/src/pages/auth/repository/auth_status.dart';
import 'package:vistoria_cfc/src/pages/auth/repository/auth_repository.dart';
import 'package:vistoria_cfc/src/pages/profile/controller/profile_controller.dart';
import 'package:vistoria_cfc/src/pages_routes/app_pages.dart';
import 'package:vistoria_cfc/src/pages/auth/result/auth_result.dart';
import 'package:vistoria_cfc/src/services/utils_services.dart';
import 'package:flutter/material.dart';

class EnhancedAuthController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final Rx<AuthStatus> authStatus = AuthStatus.unauthenticated.obs;

  final AuthRepository _authRepository;
  final UtilsServices _utilsServices;
  final Logger _logger;

  UserModel user = UserModel();

  EnhancedAuthController({
    AuthRepository? authRepository,
    UtilsServices? utilsServices,
    Logger? logger,
  })  : _authRepository = authRepository ?? AuthRepository(),
        _utilsServices = utilsServices ?? UtilsServices(),
        _logger = logger ?? Logger();

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(milliseconds: 500), () {
      if (Get.context != null) {
        validateToken(Get.context!);
      }
    });
  }

  Future<void> validateToken(BuildContext context) async {
    try {
      authStatus.value = AuthStatus.authenticating;

      final token = await _utilsServices.getLocalData(key: StorageKeys.token);
      final username =
          await _utilsServices.getLocalData(key: StorageKeys.username);
      final password =
          await _utilsServices.getLocalData(key: StorageKeys.password);

      if (token == null || username == null || password == null) {
        _handleUnauthenticated();
        return;
      }

      _logger.i('Validando token: $token');

      final result = await _authRepository.validateToken(
        token: token,
        username: username,
        password: password,
        context: context,
      );

      _handleAuthResult(result, context);
    } catch (e) {
      _handleUnexpectedError(e, context);
    }
  }

  Future<void> signIn({
    required String username,
    required String password,
    required BuildContext context,
  }) async {
    try {
      _startLoading();

      final result = await _authRepository.signIn(
        username: username,
        password: password,
        context: context,
      );

      _handleAuthResult(result, context);
    } catch (e) {
      _handleUnexpectedError(e, context);
    } finally {
      _stopLoading();
    }
  }

  Future<void> signUp(BuildContext context) async {
    try {
      _startLoading();

      final result = await _authRepository.signUp(
        user: user,
        context: context,
      );

      _handleAuthResult(result, context);
    } catch (e) {
      _handleUnexpectedError(e, context);
    } finally {
      _stopLoading();
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      user = UserModel();
      await _utilsServices.removeLocalData(key: StorageKeys.token);
      await _utilsServices.removeLocalData(key: StorageKeys.id);
      await _utilsServices.removeLocalData(key: StorageKeys.username);
      await _utilsServices.removeLocalData(key: StorageKeys.password);

      authStatus.value = AuthStatus.unauthenticated;
      Get.offAllNamed(PagesRoutes.signInRoute);

      _utilsServices.showGlobalToast(
        context: context,
        message: 'Logout realizado com sucesso!',
        isError: false,
      );
    } catch (e) {
      _logger.e('Erro durante o logout: $e');
      _utilsServices.showGlobalToast(
        context: context,
        message: 'Erro ao fazer logout',
        isError: true,
      );
    }
  }

  void _handleAuthResult(AuthResult result, BuildContext context) {
    result.when(
      success: (authenticatedUser) {
        user = authenticatedUser;
        _handleSuccessfulAuthentication(authenticatedUser, context);
        _utilsServices.showGlobalToast(
          context: context,
          message: 'Login realizada com sucesso!',
          isError: false,
        );
      },
      error: (message) {
        _handleAuthenticationError(message, context);
      },
    );
  }

  void _handleSuccessfulAuthentication(
      UserModel authenticatedUser, BuildContext context) {
    _utilsServices.saveLocalData(
      key: StorageKeys.token,
      data: authenticatedUser.token!,
    );

    if (authenticatedUser.token != null) {
      _utilsServices.saveLocalData(
        key: StorageKeys.token,
        data: authenticatedUser.token!,
      );
    }

    authStatus.value = AuthStatus.authenticated;
    Get.offAllNamed(PagesRoutes.baseRoute);

    if (!Get.isRegistered<ProfileController>()) {
      Get.put(ProfileController());
    }
    Get.find<ProfileController>().loadProfileData();
  }

  void _handleAuthenticationError(String message, BuildContext context) {
    authStatus.value = AuthStatus.error;
    errorMessage.value = message;

    _utilsServices.showGlobalToast(
      context: context,
      message: message,
      isError: true,
    );

    if (message.contains('Token inválido') ||
        message.contains('Sem permissão')) {
      signOut(context);
    }
  }

  void _handleUnexpectedError(dynamic error, BuildContext context) {
    _logger.e('Erro inesperado: $error');

    authStatus.value = AuthStatus.error;
    errorMessage.value = 'Erro inesperado. Tente novamente.';

    _utilsServices.showGlobalToast(
      context: context,
      message: 'Erro inesperado. Tente novamente.',
      isError: true,
    );
  }

  void _handleUnauthenticated() {
    authStatus.value = AuthStatus.unauthenticated;
    Get.offAllNamed(PagesRoutes.signInRoute);
  }

  void _startLoading() {
    isLoading.value = true;
    authStatus.value = AuthStatus.authenticating;
    errorMessage.value = '';
  }

  void _stopLoading() {
    isLoading.value = false;
  }
}
