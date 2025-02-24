// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cfc_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CfcModel _$CfcModelFromJson(Map<String, dynamic> json) => CfcModel(
      id: json['id'] as String?,
      centroDeFormacao: json['centroDeFormacao'] as String,
      fantasia: json['fantasia'] as String,
      situacao: json['situacao'] as String,
      cnpj: json['cnpj'] as String,
      email: json['email'] as String,
      cep: json['cep'] as String,
      endereco: json['endereco'] as String,
      numero: json['numero'] as String,
      bairro: json['bairro'] as String,
      cidade: json['cidade'] as String,
      estado: json['estado'] as String,
      telefone: json['telefone'] as String,
      tipo: json['tipo'] as String,
      data: DateTime.parse(json['data'] as String),
    );

Map<String, dynamic> _$CfcModelToJson(CfcModel instance) => <String, dynamic>{
      'id': instance.id,
      'centroDeFormacao': instance.centroDeFormacao,
      'fantasia': instance.fantasia,
      'situacao': instance.situacao,
      'cnpj': instance.cnpj,
      'email': instance.email,
      'cep': instance.cep,
      'endereco': instance.endereco,
      'numero': instance.numero,
      'bairro': instance.bairro,
      'cidade': instance.cidade,
      'estado': instance.estado,
      'telefone': instance.telefone,
      'tipo': instance.tipo,
      'data': instance.data.toIso8601String(),
    };
