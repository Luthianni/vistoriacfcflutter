import 'package:freezed_annotation/freezed_annotation.dart';

part 'vistoria_model.g.dart';

@JsonSerializable()
class VistoriaModel {
  String? id;
  String? cfcName;
  String? imgUrl;
  String? cnpj;

  @JsonKey(defaultValue: [])
  List<VistoriaModel>? allVistorias;

  VistoriaModel({
    this.id,
    this.cfcName,
    this.imgUrl,
    this.cnpj,
  });

  factory VistoriaModel.fromJson(Map<String, dynamic> json) =>
      _$VistoriaModelFromJson(json);

  Map<String, dynamic> toJson() => _$VistoriaModelToJson(this);

  @override
  String toString() {
    return 'VistoriaModel(id: $id, cfcName: $cfcName, imgUrl: $imgUrl, cnpj: $cnpj)';
  }
}
