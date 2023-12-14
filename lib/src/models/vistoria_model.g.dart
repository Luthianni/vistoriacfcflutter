part of 'vistoria_model.dart';

VistoriaModel _$VistoriaModelfromJson(Map<String, dynamic> json) =>
    VistoriaModel(
      id: json["id"] as String?,
      cfcName: json["cfcName"] as String?,
      imgUrl: json["imgUrl"] as String?,
      cnpj: json["cnpj"] as String?,
      logradouro: json["logradouro"] as String?,
      bairro: json["bairro"] as String?,
      cidade: json["cidade"] as String?,
      estado: json["estado"] as String?,
      cep: json["cep"] as String?,
      horaAgendada: json["horaAgendada"] as String?,
      dataAgendamento: json["dataAgendamento"] as String?,
      vistoriadorResp: json["vistoriadorResp"] as String?,
      descricao: json["descricao"] as String?,
    );

Map<String, dynamic> _$VistoriaModelToJson(VistoriaModel instance) =>
    <String, dynamic>{
      "id": instance.id,
      "cfcName": instance.cfcName,
      "imgUrl": instance.imgUrl,
      "cnpj": instance.cnpj,
      "logradouro": instance.logradouro,
      "bairro": instance.bairro,
      "cidade": instance.cidade,
      "estado": instance.estado,
      "cep": instance.cep,
      "horaAgendada": instance.horaAgendada,
      "dataAgendamento": instance.dataAgendamento,
      "vistoriadorResp": instance.vistoriadorResp,
      "descricao": instance.descricao,
    };
