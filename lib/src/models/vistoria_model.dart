import 'package:freezed_annotation/freezed_annotation.dart';

part 'vistoria_model.g.dart';

@JsonSerializable()
class VistoriaModel {
  String? id;
  String? cfcName;
  String? imgUrl;
  String? cnpj;
  String? logradouro;
  String? bairro;
  String? cidade;
  String? estado;
  String? cep;
  String? horaAgendada;
  String? dataAgendamento;
  String? vistoriadorResp;
  String? descricao;
  @JsonKey(defaultValue: [])
  List<VistoriaModel>? listaDeItens;

  VistoriaModel({
    this.id,
    this.cfcName,
    this.imgUrl,
    this.cnpj,
    this.logradouro,
    this.bairro,
    this.cidade,
    this.estado,
    this.cep,
    this.horaAgendada,
    this.dataAgendamento,
    this.vistoriadorResp,
    this.descricao,
    this.listaDeItens = const [],
  });

  factory VistoriaModel.fromJson(Map<String, dynamic> json) =>
      _$VistoriaModelfromJson(json);

  Map<String, dynamic> toJson() => _$VistoriaModelToJson(this);

  // @override
  // String toString() {
  //   return 'VistoriaModel(id: $id, cfcName: $cfcName, imgUrl: $imgUrl, cnpj: $cnpj, logradouro: $logradouro, bairro: $bairro, cidade: $cidade, estado: $estado, cep: $cep, horaAgendada: $horaAgendada, dataAgendamento: $dataAgendamento, vistoriadorResp: $vistoriadorResp, descricao: $descricao, listaDeItens: $listaDeItens)';
  // }
}
