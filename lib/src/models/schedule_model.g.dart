part of 'schedule_model.dart';

ScheduleModel _$ScheduleModelFromJson(Map<String, dynamic> json) {
  return ScheduleModel(
    centroDeFormacao: json['centroDeFormacao'] as String,
    cnpj: json['cnpj'] as String,
    inscricaoEstadual: json['inscricaoEstadual'] as String,
    email: json['email'] as String,
    cep: json['cep'] as String,
    endereco: json['endereco'] as String,
    numero: json['numero'] as String,
    bairro: json['bairro'] as String,
    cidade: json['cidade'] as String,
    estado: json['estado'] as String,
    telefone: json['telefone'] as String,
    celular: json['celular'] as String,
    data: DateTime.parse(json['data'] as String),
  );
}

Map<String, dynamic> _$ScheduleModelToJson(ScheduleModel instance) => <String, dynamic>{
  'centroDeFormacao': instance.centroDeFormacao,
  'cnpj': instance.cnpj,
  'inscricaoEstadual': instance.inscricaoEstadual,
  'email': instance.email,
  'cep': instance.cep,
  'endereco': instance.endereco,
  'numero': instance.numero,
  'bairro': instance.bairro,
  'cidade': instance.cidade,
  'estado': instance.estado,
  'telefone': instance.telefone,
  'celular': instance.celular,
  'data': instance.data.toIso8601String(),
};
