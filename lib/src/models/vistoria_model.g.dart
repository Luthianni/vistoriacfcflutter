part of 'vistoria_model.dart';

VistoriaModel _$VistoriaModelfromJson(Map<String, dynamic> json) =>
    VistoriaModel(
      id: json["id"] as String?,
      cfcName: json["cfcName"] as String?,
      imgUrl: json["imgUrl"] as String?,
      cnpj: json["cnpj"] as String?,
    );

Map<String, dynamic> _$VistoriaModelToJson(VistoriaModel instance) =>
    <String, dynamic>{
      "id": instance.id,
      "cfcName": instance.cfcName,
      "imgUrl": instance.imgUrl,
      "cnpj": instance.cnpj,
    };
