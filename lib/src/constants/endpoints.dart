// CONNECTION BACK-END //
//const String baseUrl = 'http://192.168.0.200:8080/api/v1';
const String baseUrl = 'http://localhost:8080';
//const String baseUrl = 'http://172.25.137.54:8080/api/v1';
//const String baseUrl = 'http://7c47-177-22-43-111.ngrok-free.app';

abstract class Endpoints {
  // AUTH //
  static const String signin = '$baseUrl/api/v1/auth';
  static const String validateToken = '$baseUrl/api/v1/validateToken';
  static const String signup = '$baseUrl/api/v1/signup';
  // USERS //
  static const String usuarios = '$baseUrl/api/v1/usuarios';
  static const String profileId = '$baseUrl/api/v1/profile';
  // CENTRO DE FORMAÇÃO //
  static const String centroFormacaoCondutores =
      '$baseUrl/centroFormacaoCondutores';
  static const String enderecos = '$baseUrl/api/v1/enderecos';
  // VISTORIAS //
  static const String vistoria = '$baseUrl/api/v1/vistoria';
  static const String getAllVistorias = '$baseUrl/api/v1/get-vistorias-list';
  // PASSWORD //
  static const String resetPassword = '$baseUrl/api/v1/reset-password';
  static const String changePassword = '$baseUrl/api/v1/change-password';
}
