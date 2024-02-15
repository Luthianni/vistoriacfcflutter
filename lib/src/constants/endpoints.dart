const String baseUrl = 'http://192.168.0.200:8080/api/v1';

abstract class Endpoints {
  static const String signin = '$baseUrl/auth';
  static const String validateToken = '$baseUrl/validateToken';
  static const String usuarios = '$baseUrl/usuarios';
  static const String servidores = '$baseUrl/servidores';
  static const String centroFormacaoCondutores =
      '$baseUrl/centroFormacaoCondutores';
  static const String enderecos = '$baseUrl/enderecos';
  static const String vistoria = '$baseUrl/vistoria';
  static const String getAllVistorias = '$baseUrl/get-vistorias-list';
  static const String resetPassword = '$baseUrl/reset-password';
  static const String changePassword = '$baseUrl/change-password';
  static const String signup = '$baseUrl/signup';
}
