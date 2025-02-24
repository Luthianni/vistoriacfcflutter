import 'package:json_annotation/json_annotation.dart';

part 'cfc_model.g.dart';

@JsonSerializable()
class CfcModel {
  final String? id;
  final String centroDeFormacao;
  final String fantasia;
  final String situacao;
  final String cnpj;
  final String email;
  final String cep;
  final String endereco;
  final String numero;
  final String bairro;
  final String cidade;
  final String estado;
  final String telefone;
  final String tipo;
  final DateTime data;

  CfcModel({
    required this.id,
    required this.centroDeFormacao,
    required this.fantasia,
    required this.situacao,
    required this.cnpj,
    required this.email,
    required this.cep,
    required this.endereco,
    required this.numero,
    required this.bairro,
    required this.cidade,
    required this.estado,
    required this.telefone,
    required this.tipo,
    required this.data,
  });

  factory CfcModel.fromJson(Map<String, dynamic> json) =>
      _$CfcModelFromJson(json);

  Map<String, dynamic> toJson() => _$CfcModelToJson(this);

  @override
  String toString() {
    return 'CfcModel(id: $id,centroDeFormacao: $centroDeFormacao, fantasia: $fantasia, situacao: $situacao, razaoSocial cnpj: $cnpj, email: $email, cep: $cep, endereco: $endereco, numero: $numero, bairro: $bairro, cidade: $cidade, estado: $estado, telefone: $telefone, tipo: $tipo, data: $data)';
  }
}
