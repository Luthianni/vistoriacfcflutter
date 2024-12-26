import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:vistoria_cfc/src/constants/storage_keys.dart';
import 'package:vistoria_cfc/src/models/user_model.dart';
import 'package:vistoria_cfc/src/pages/auth/repository/auth_status.dart';
import 'package:vistoria_cfc/src/pages/auth/repository/auth_repository.dart';
import 'package:vistoria_cfc/src/pages/profile/controller/profile_controller.dart';
import 'package:vistoria_cfc/src/services/utils_services.dart';
import 'package:vistoria_cfc/src/pages/auth/result/auth_result.dart';
import 'package:vistoria_cfc/src/pages_routes/app_pages.dart';

class EnhancedAuthController extends GetxController {
  // Estados Observáveis
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final Rx<AuthStatus> authStatus = AuthStatus.unauthenticated.obs;

  // Dependências
  final AuthRepository _authRepository;
  final UtilsServices _utilsServices;
  final Logger _logger;

  // Estado do usuário
  UserModel user = UserModel();

  // Construtor com injeção de dependências
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
    validateToken();
  }

  // Método de validação de token com tratamento de erros aprimorado
  Future<void> validateToken() async {
    try {
      authStatus.value = AuthStatus.authenticating;
      
      String? token = await _utilsServices.getLocalData(key: StorageKeys.token);
      String? username = await _utilsServices.getLocalData(key: StorageKeys.username);
      String? password = await _utilsServices.getLocalData(key: StorageKeys.password);
      
      if (token == null || username == null || password == null) {
        _handleUnauthenticated();
        return;
      }

      _logger.i('Validando token: $token');

      AuthResult result = await _authRepository.validateToken(
        token: token,
        username: username,
        password: password,
      );

      result.when(
        success: (authenticatedUser) {
          _handleSuccessfulAuthentication(authenticatedUser);
        },
        error: (message) {
          _handleAuthenticationError(message);
        },
      );
    } catch (e) {
      _handleUnexpectedError(e);
    }
  }

  // Método de login com tratamento de erros detalhado
  Future<void> signIn({
    required String username,
    required String password,
  }) async {
    try {
      isLoading.value = true;
      authStatus.value = AuthStatus.authenticating;
      errorMessage.value = '';

      AuthResult result = await _authRepository.signIn(
        username: username,
        password: password,
      );

      result.when(
        success: (authenticatedUser) async {
          user = authenticatedUser;
          
          // Verificar se o ProfileController está registrado
          if (!Get.isRegistered<ProfileController>()) {
            Get.put(ProfileController()); // Registrar o ProfileController, se necessário
          }

          final profileController = Get.find<ProfileController>();
          await profileController.loadProfileData();

          _handleSuccessfulAuthentication(authenticatedUser);
        },
        error: (message) {
          _handleAuthenticationError(message);
        },
      );
    } catch (e) {
      _handleUnexpectedError(e);
    } finally {
      isLoading.value = false;
    }
  }

  // Método de registro com tratamento de erros
  Future<void> signUp() async {
    try {
      isLoading.value = true;
      authStatus.value = AuthStatus.authenticating;
      errorMessage.value = '';

      AuthResult result = await _authRepository.signUp(user);

      result.when(
        success: (registeredUser) {
          user = registeredUser;
          _handleSuccessfulAuthentication(registeredUser);
        },
        error: (message) {
          _handleAuthenticationError(message);
        },
      );
    } catch (e) {
      _handleUnexpectedError(e);
    } finally {
      isLoading.value = false;
    }
  }

  // Tratamento de autenticação bem-sucedida
  void _handleSuccessfulAuthentication(UserModel authenticatedUser) {
    _utilsServices.saveLocalData(
      key: StorageKeys.token, 
      data: authenticatedUser.token!
    );

    if (authenticatedUser.id != null) {
      _utilsServices.saveLocalData(
        key: StorageKeys.id, 
        data: authenticatedUser.id.toString()
      );
    }

    authStatus.value = AuthStatus.authenticated;
    Get.offAllNamed(PagesRoutes.baseRoute);
  }

  // Tratamento de erro de autenticação
  void _handleAuthenticationError(String message) {
    authStatus.value = AuthStatus.error;
    errorMessage.value = message;
    
    _utilsServices.showToast(
      message: message,
      isError: true,
    );

    // Se o erro for crítico, faz logout
    if (message.contains('Token inválido') || 
        message.contains('Sem permissão')) {
      signOut();
    }
  }

  // Tratamento de erros inesperados
  void _handleUnexpectedError(dynamic error) {
    _logger.e('Erro inesperado de autenticação: $error');
    
    authStatus.value = AuthStatus.error;
    errorMessage.value = 'Erro inesperado. Tente novamente.';
    
    _utilsServices.showToast(
      message: 'Erro inesperado. Tente novamente.',
      isError: true,
    );
  }

  // Lidar com estado não autenticado
  void _handleUnauthenticated() {
    authStatus.value = AuthStatus.unauthenticated;
    Get.offAllNamed(PagesRoutes.signInRoute);
  }

  // Método de logout
  Future<void> signOut() async {
    try {
      user = UserModel();
      await _utilsServices.removeLocalData(key: StorageKeys.token);
      await _utilsServices.removeLocalData(key: StorageKeys.id);
      
      authStatus.value = AuthStatus.unauthenticated;
      Get.offAllNamed(PagesRoutes.signInRoute);
    } catch (e) {
      _logger.e('Erro durante o logout: $e');
      _utilsServices.showToast(
        message: 'Erro ao fazer logout',
        isError: true,
      );
    }
  }
}