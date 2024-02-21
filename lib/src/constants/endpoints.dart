// CONNECTION BACK-END //
const String baseUrl = 'http://192.168.0.200:8080/api/v1';
//const String baseUrl = 'http://172.25.137.54:8080/api/v1';

abstract class Endpoints {
  // AUTH //
  static const String signin = '$baseUrl/auth';
  static const String validateToken = '$baseUrl/validateToken';
  static const String signup = '$baseUrl/signup';
  // USERS //
  static const String usuarios = '$baseUrl/usuarios';
  // SERVIDORES //
  static const String servidores = '$baseUrl/servidores';
  static const String centroFormacaoCondutores =
      '$baseUrl/centroFormacaoCondutores';
  static const String enderecos = '$baseUrl/enderecos';
  // VISTORIAS //
  static const String vistoria = '$baseUrl/vistoria';
  static const String getAllVistorias = '$baseUrl/get-vistorias-list';
  // PASSWORD //
  static const String resetPassword = '$baseUrl/reset-password';
  static const String changePassword = '$baseUrl/change-password';
}
