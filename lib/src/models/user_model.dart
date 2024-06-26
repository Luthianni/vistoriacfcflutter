import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  String? username;
  String? password;
  dynamic id;
  String? token;
  String? email;
  

  UserModel({
    this.username,
    this.password,
    this.id,
    this.token,
    this.email,   
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  String toString() {
    return 'UserModel(username: $username, password: $password, id: $id, token: $token, email: $email)';
  }
}
