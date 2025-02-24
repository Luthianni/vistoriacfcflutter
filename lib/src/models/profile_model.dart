import 'package:json_annotation/json_annotation.dart';

part 'profile_model.g.dart';

@JsonSerializable()
class ProfileModel {
  dynamic id;
  String? nome;
  String? cpf;
  String? matricula;
  String? email;
  String? telefone;
  String? foto;

  ProfileModel(
      {this.id,
      this.nome,
      this.cpf,
      this.matricula,
      this.email,
      this.telefone,
      this.foto});

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);

  @override
  String toString() {
    return 'ProfileModel(id: $id, nome: $nome, cpf: $cpf, matricula: $matricula, email: $email, telefone: $telefone, foto: $foto)';
  }
}
