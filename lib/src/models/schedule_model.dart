import 'package:json_annotation/json_annotation.dart';

part 'schedule_model.g.dart';

@JsonSerializable()
class ScheduleModel {
  final String centroDeFormacao;
  final String cnpj;
  final String inscricaoEstadual;
  final String email;
  final String cep;
  final String endereco;
  final String numero;
  final String bairro;
  final String cidade;
  final String estado;
  final String telefone;
  final String celular;
  final DateTime data;

  ScheduleModel({
    required this.centroDeFormacao,
    required this.cnpj,
    required this.inscricaoEstadual,
    required this.email,
    required this.cep,
    required this.endereco,
    required this.numero,
    required this.bairro,
    required this.cidade,
    required this.estado,
    required this.telefone,
    required this.celular,
    required this.data,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) =>
      _$ScheduleModelFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleModelToJson(this);

  @override
  String toString() {
    return 'ScheduleModel(centroDeFormacao: $centroDeFormacao, cnpj: $cnpj, inscricaoEstadual: $inscricaoEstadual, email: $email, cep: $cep, endereco: $endereco, numero: $numero, bairro: $bairro, cidade: $cidade, estado: $estado, telefone: $telefone, celular: $celular, data: $data)';
  }
}