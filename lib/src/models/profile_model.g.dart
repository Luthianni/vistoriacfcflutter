// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) => ProfileModel(
      id: json['id'],
      nome: json['nome'] as String?,
      cpf: json['cpf'] as String?,
      matricula: json['matricula'] as String?,
      email: json['email'] as String?,
      telefone: json['telefone'] as String?,
      foto: json['foto'] as String?,
    );

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nome': instance.nome,
      'cpf': instance.cpf,
      'matricula': instance.matricula,
      'email': instance.email,
      'telefone': instance.telefone,
      'foto': instance.foto,
    };
