import 'dart:convert';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;
import 'package:vistoria_cfc/src/models/cfc_model.dart';
import 'package:vistoria_cfc/src/pages/cfc/controller/cfc_controller.dart';
import 'package:vistoria_cfc/src/pages/auth/controller/auth_controller.dart';

class CfcTab extends StatefulWidget {
  const CfcTab({super.key});

  @override
  State<CfcTab> createState() => _CfcTabState();
}

class _CfcTabState extends State<CfcTab> {
  final _formKey = GlobalKey<FormState>();
  final CfcController _cfcController = Get.find<CfcController>();
  final authController = Get.find<EnhancedAuthController>();
  final Logger logger = Logger();

  // Agrupando os controllers para melhor organização
  final _formControllers = _FormControllers();

  @override
  void dispose() {
    _formControllers.dispose();
    super.dispose();
  }

  Future<void> _fetchCompanyDetails(String cnpj) async {
    try {
      // Remove caracteres especiais do CNPJ
      final cleanCnpj = cnpj.replaceAll(RegExp(r'[^\d]'), '');

      if (cleanCnpj.length != 14) {
        _showErrorSnackBar('CNPJ deve conter 14 dígitos');
        return;
      }

      // Mostrar loading
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );

      logger.i('Buscando detalhes da empresa para o CNPJ: $cleanCnpj');

      final response = await http.get(
        Uri.parse('https://www.receitaws.com.br/v1/cnpj/$cleanCnpj'),
      );

      // Fechar loading
      Navigator.pop(context);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        // Verifica se a resposta contém erro
        if (jsonResponse['status'] == 'ERROR') {
          _showErrorSnackBar(
              jsonResponse['message'] ?? 'Erro ao buscar dados do CNPJ');
          return;
        }

        setState(() {
          _populateFormFields(jsonResponse);
        });

        _showSuccessSnackBar('Dados do CNPJ carregados com sucesso!');
      } else {
        logger.e('Falha ao buscar dados da empresa: ${response.statusCode}');
        _showErrorSnackBar(
            'Falha ao buscar dados da empresa. Verifique o CNPJ informado');
      }
    } catch (e) {
      // Fechar loading se houver erro
      Navigator.pop(context);

      logger.e('Erro ao buscar dados da empresa: $e');
      _showErrorSnackBar(
          'Erro ao buscar dados da empresa. Tente novamente mais tarde.');
    }
  }

  Widget _buildCnpjField() {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: _formControllers.cnpjController,
            decoration: const InputDecoration(
              labelText: 'CNPJ',
              floatingLabelBehavior: FloatingLabelBehavior.always,
              fillColor: Color.fromARGB(255, 240, 238, 238),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide.none,
              ),
              labelStyle: TextStyle(color: Color.fromARGB(255, 136, 135, 135)),
              hintText: '00.000.000/0000-00',
              filled: true,
              hintStyle: TextStyle(color: Color.fromARGB(255, 136, 135, 135)),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'CNPJ é obrigatório';
              }
              if (value.replaceAll(RegExp(r'[^\d]'), '').length != 14) {
                return 'CNPJ inválido';
              }
              return null;
            },
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton.icon(
          onPressed: () {
            final cnpj = _formControllers.cnpjController.text;
            if (cnpj.isNotEmpty) {
              _fetchCompanyDetails(cnpj);
            } else {
              _showErrorSnackBar('Digite um CNPJ para consultar');
            }
          },
          icon: const Icon(Icons.search, color: Colors.white),
          label: const Text(
            'Buscar',
            style: TextStyle(
              color: Color.fromARGB(255, 248, 248, 248),
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 106, 193, 145),
          ),
        ),
      ],
    );
  }

  void _populateFormFields(Map<String, dynamic> data) {
    _formControllers.tipoController.text = data['tipo'] ?? '';
    _formControllers.centroDeFormacaoController.text = data['nome'] ?? '';
    _formControllers.fantasiaController.text = data['fantasia'] ?? '';
    _formControllers.cnpjController.text = data['cnpj'] ?? '';
    _formControllers.emailController.text = data['email'] ?? '';
    _formControllers.telefoneController.text = data['telefone'] ?? '';
    _formControllers.cepController.text =
        data['cep']?.replaceAll(RegExp(r'[^\d]'), '') ?? '';
    _formControllers.enderecoController.text = data['logradouro'] ?? '';
    _formControllers.numeroController.text = data['numero'] ?? '';
    _formControllers.bairroController.text = data['bairro'] ?? '';
    _formControllers.cidadeController.text = data['municipio'] ?? '';
    _formControllers.estadoController.text = data['uf'] ?? '';
    _formControllers.situacaoController.text = data['situacao'] ?? '';
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      final cfc = CfcModel(
        id: null, // Adicionando o id como null para novo registro
        tipo: _formControllers.tipoController.text,
        centroDeFormacao: _formControllers.centroDeFormacaoController.text,
        fantasia: _formControllers.fantasiaController.text,
        cnpj: _formControllers.cnpjController.text,
        email: _formControllers.emailController.text,
        telefone: _formControllers.telefoneController.text,
        cep: _formControllers.cepController.text,
        endereco: _formControllers.enderecoController.text,
        numero: _formControllers.numeroController.text,
        bairro: _formControllers.bairroController.text,
        cidade: _formControllers.cidadeController.text,
        estado: _formControllers.estadoController.text,
        situacao: _formControllers.situacaoController.text,
        data: DateTime.now(),
      );

      await _cfcController.createCfc(cfc);
      _showSuccessSnackBar('CFC cadastrado com sucesso!');
      _formKey.currentState!.reset();
      _formControllers.clear();
    } catch (e) {
      _showErrorSnackBar('Erro ao cadastrar CFC: $e');
    }
  }

  void _showErrorSnackBar(String message) {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Erro',
        message: message,
        contentType: ContentType.failure,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _showSuccessSnackBar(String message) {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Sucesso',
        message: message,
        contentType: ContentType.success,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 106, 193, 145),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Cadastro de CFC',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(255, 255, 255, 1.0),
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Card(
            color: Colors.white,
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildCnpjField(),
                  const SizedBox(height: 16),
                  _buildCompanyInfoFields(),
                  const SizedBox(height: 16),
                  _buildAddressFields(),
                  const SizedBox(height: 16),
                  _buildContactFields(),
                  const SizedBox(height: 24),
                  _buildSubmitButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCompanyInfoFields() {
    return Column(
      children: [
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: TextFormField(
                controller: _formControllers.tipoController,
                decoration: const InputDecoration(
                  labelText: 'Tipo',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  filled: true,
                  fillColor: Color.fromARGB(255, 240, 238, 238),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide.none,
                  ),
                  labelStyle: TextStyle(color: Color.fromARGB(255, 39, 39, 39)),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                ),
                readOnly: true,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              flex: 1,
              child: TextFormField(
                controller: _formControllers.situacaoController,
                decoration: const InputDecoration(
                  labelText: 'Situação',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  filled: true,
                  fillColor: Color.fromARGB(255, 240, 238, 238),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide.none,
                  ),
                  labelStyle: TextStyle(color: Colors.black),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _formControllers.centroDeFormacaoController,
          decoration: const InputDecoration(
            labelText: 'Centro de Formação',
            floatingLabelBehavior: FloatingLabelBehavior.always,
            filled: true,
            fillColor: Color.fromARGB(255, 240, 238, 238),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide.none,
            ),
            labelStyle: TextStyle(color: Colors.black),
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          ),
          readOnly: true,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _formControllers.fantasiaController,
          decoration: const InputDecoration(
            labelText: 'Nome Fantasia',
            floatingLabelBehavior: FloatingLabelBehavior.always,
            filled: true,
            fillColor: Color.fromARGB(255, 240, 238, 238),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide.none,
            ),
            labelStyle: TextStyle(color: Colors.black),
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          ),
          readOnly: true,
        ),
      ],
    );
  }

  Widget _buildAddressFields() {
    return Column(
      children: [
        TextFormField(
          controller: _formControllers.enderecoController,
          decoration: const InputDecoration(
            labelText: 'Endereço',
            floatingLabelBehavior: FloatingLabelBehavior.always,
            filled: true,
            fillColor: Color.fromARGB(255, 240, 238, 238),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide.none,
            ),
            labelStyle: TextStyle(color: Colors.black),
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: TextFormField(
                controller: _formControllers.numeroController,
                decoration: const InputDecoration(
                  labelText: 'Número',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  filled: true,
                  fillColor: Color.fromARGB(255, 240, 238, 238),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide.none,
                  ),
                  labelStyle: TextStyle(color: Colors.black),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              flex: 1,
              child: TextFormField(
                controller: _formControllers.cepController,
                decoration: const InputDecoration(
                  labelText: 'CEP',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  filled: true,
                  fillColor: Color.fromARGB(255, 240, 238, 238),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide.none,
                  ),
                  labelStyle: TextStyle(color: Colors.black),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _formControllers.bairroController,
          decoration: const InputDecoration(
            labelText: 'Bairro',
            floatingLabelBehavior: FloatingLabelBehavior.always,
            filled: true,
            fillColor: Color.fromARGB(255, 240, 238, 238),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide.none,
            ),
            labelStyle: TextStyle(color: Colors.black),
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: TextFormField(
                controller: _formControllers.cidadeController,
                decoration: const InputDecoration(
                  labelText: 'Cidade',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  filled: true,
                  fillColor: Color.fromARGB(255, 240, 238, 238),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide.none,
                  ),
                  labelStyle: TextStyle(color: Colors.black),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: TextFormField(
                controller: _formControllers.estadoController,
                decoration: const InputDecoration(
                  labelText: 'Estado',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  filled: true,
                  fillColor: Color.fromARGB(255, 240, 238, 238),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide.none,
                  ),
                  labelStyle: TextStyle(color: Colors.black),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContactFields() {
    return Column(
      children: [
        TextFormField(
          controller: _formControllers.emailController,
          decoration: const InputDecoration(
            labelText: 'Email',
            floatingLabelBehavior: FloatingLabelBehavior.always,
            filled: true,
            fillColor: Color.fromARGB(255, 240, 238, 238),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide.none,
            ),
            labelStyle: TextStyle(color: Colors.black),
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Email é obrigatório';
            }
            if (!value.contains('@')) {
              return 'Email inválido';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _formControllers.telefoneController,
          decoration: const InputDecoration(
            labelText: 'Telefone',
            floatingLabelBehavior: FloatingLabelBehavior.always,
            filled: true,
            fillColor: Color.fromARGB(255, 240, 238, 238),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide.none,
            ),
            labelStyle: TextStyle(color: Colors.black),
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: _submitForm,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        backgroundColor: const Color.fromARGB(255, 106, 193, 145),
      ),
      child: const Text(
        'Salvar CFC',
        style: TextStyle(
          color: Color.fromARGB(255, 248, 248, 248),
          fontSize: 18,
        ),
      ),
    );
  }
}

// Classe auxiliar para gerenciar os controllers do formulário
class _FormControllers {
  final tipoController = TextEditingController();
  final centroDeFormacaoController = TextEditingController();
  final fantasiaController = TextEditingController();
  final cnpjController = TextEditingController();
  final emailController = TextEditingController();
  final telefoneController = TextEditingController();
  final cepController = TextEditingController();
  final enderecoController = TextEditingController();
  final numeroController = TextEditingController();
  final bairroController = TextEditingController();
  final cidadeController = TextEditingController();
  final estadoController = TextEditingController();
  final situacaoController = TextEditingController();

  void clear() {
    tipoController.clear();
    centroDeFormacaoController.clear();
    fantasiaController.clear();
    cnpjController.clear();
    emailController.clear();
    telefoneController.clear();
    cepController.clear();
    enderecoController.clear();
    numeroController.clear();
    bairroController.clear();
    cidadeController.clear();
    estadoController.clear();
  }

  void dispose() {
    tipoController.dispose();
    centroDeFormacaoController.dispose();
    fantasiaController.dispose();
    cnpjController.dispose();
    emailController.dispose();
    telefoneController.dispose();
    cepController.dispose();
    enderecoController.dispose();
    numeroController.dispose();
    bairroController.dispose();
    cidadeController.dispose();
    estadoController.dispose();
  }
}
