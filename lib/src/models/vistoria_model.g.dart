// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vistoria_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VistoriaModel _$VistoriaModelFromJson(Map<String, dynamic> json) =>
    VistoriaModel(
      id: json['id'] as String?,
      cfcName: json['cfcName'] as String?,
      imgUrl: json['imgUrl'] as String?,
      cnpj: json['cnpj'] as String?,
    )..allVistorias = (json['allVistorias'] as List<dynamic>?)
            ?.map((e) => VistoriaModel.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [];

Map<String, dynamic> _$VistoriaModelToJson(VistoriaModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cfcName': instance.cfcName,
      'imgUrl': instance.imgUrl,
      'cnpj': instance.cnpj,
      'allVistorias': instance.allVistorias,
    };
