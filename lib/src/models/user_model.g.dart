// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      username: json['username'] as String?,
      password: json['password'] as String?,
      id: json['id'],
      token: json['token'] as String?,
      email: json['email'] as String?,
      nome: json['nome'] as String?,
      cpf: json['cpf'] as String?,
      matricula: json['matricula'] as String?,
      telefone: json['telefone'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
      'id': instance.id,
      'token': instance.token,
      'email': instance.email,
      'nome': instance.nome,
      'cpf': instance.cpf,
      'matricula': instance.matricula,
      'telefone': instance.telefone,
    };
