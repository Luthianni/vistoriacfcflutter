import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vistoria_cfc/src/models/user_model.dart';

part 'auth_result.freezed.dart';

@freezed
class AuthResult with _$AuthResult {
  factory AuthResult.authSuccess(UserModel user) = AuthSuccess;
  factory AuthResult.authError(String message) = AuthError;
}
