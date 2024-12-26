import 'package:get/get.dart';

String? emailValidator(String? email) {
  if (email == null || email.isEmpty) {
    return 'Digite o seu email!';
  }

  if (!email.isEmail) return 'Digite um email válido!';

  return null;
}

String? passwordValidator(password) {
  if (password == null || password.isEmpty) {
    return 'Digite a senha !';
  }

  if (password.length < 6) {
    return 'Digite uma senha com pelo menos 6 caracteres.';
  }

  return null;
}

String? nameValidator(String? name) {
  if (name == null || name.isEmpty) {
    return 'Digite um nome!';
  }

  final names = name.split('');

  if (names.length == 1) return 'Digite o seu nome completo!';

  return null;
}

String? phoneValidator(String? phone) {
  if (phone == null || phone.isEmpty) {
    return 'Digite um celular !';
  }

  if (phone.length < 14 || !phone.isPhoneNumber) {
    return 'Digite um número válido!';
  }

  return null;
}

String? cpfvalidator(String? cpf) {
  if (cpf == null || cpf.isEmpty) {
    return 'Digite um CPF!';
  }

  if (!cpf.isCpf) return 'Digite um CPF válido!';

  return null;
}

String? cnpjvalidator(String? cnpj) {
  if (cnpj == null || cnpj.isEmpty) {
    return 'Digite um CNPJ';
  }

  if (!cnpj.isCnpj) return 'Digite um CNPJ válido!';

  return null;
}

String? inscricaoEstadualValidator(String? inscricaoEstadual) {
  if (inscricaoEstadual == null || inscricaoEstadual.isEmpty) {
    return 'Digite a inscrição estadual!';
  }

  return null;
}

String? cepValidator(String? cep) {
  if (cep == null || cep.isEmpty) {
    return 'Digite o CEP!';
  }
  
  return null;
}