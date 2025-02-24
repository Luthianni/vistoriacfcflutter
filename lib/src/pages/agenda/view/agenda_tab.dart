import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:vistoria_cfc/src/models/schedule_model.dart';
import 'package:vistoria_cfc/src/pages/common_widgets/custom_text_field.dart';
import 'package:vistoria_cfc/src/services/validators.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

var now = DateTime.now();
var firstDay = DateTime(now.year, now.month - 3, now.day);
var lastDay = DateTime(now.year, now.month + 3, now.day);

class AgendaTab extends StatefulWidget {
  final Function(ScheduleModel) onAgendamentoSalvo;

  const AgendaTab({super.key, required this.onAgendamentoSalvo});

  @override
  State<AgendaTab> createState() => _AgendaTabSelectorState();
}

class _AgendaTabSelectorState extends State<AgendaTab> {
  CalendarFormat format = CalendarFormat.twoWeeks;

  final TextEditingController centroDeFormacaoController =
      TextEditingController();
  final TextEditingController cnpjController = TextEditingController();
  final TextEditingController tipoController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController cepController = TextEditingController();
  final TextEditingController enderecoController = TextEditingController();
  final TextEditingController numeroController = TextEditingController();
  final TextEditingController bairroController = TextEditingController();
  final TextEditingController cidadeController = TextEditingController();
  final TextEditingController estadoController = TextEditingController();
  final TextEditingController telefoneController = TextEditingController();

  final Logger logger = Logger();

  Future<void> _fetchCompanyDetails(String cnpj) async {
    logger.i('Buscando detalhes da empresa pelo CNPJ: $cnpj');

    final response =
        await http.get(Uri.parse('https://www.receitaws.com.br/v1/cnpj/$cnpj'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'OK') {
        setState(() {
          centroDeFormacaoController.text = data['nome'] ?? '';
          tipoController.text = data['tipo'] ?? '';
          emailController.text = data['email'] ?? '';
          cepController.text = data['cep'] ?? '';
          enderecoController.text = data['logradouro'] ?? '';
          numeroController.text = data['numero'] ?? '';
          bairroController.text = data['bairro'] ?? '';
          cidadeController.text = data['municipio'] ?? '';
          estadoController.text = data['uf'] ?? '';
          telefoneController.text = data['telefone'] ?? '';
        });
      } else {
        logger.w('Falha ao buscar dados da empresa: ${data['message']}');
        _showErrorSnackBar(
            'Falha ao buscar dados da empresa. Verifique o CNPJ.');
      }
    } else {
      logger.e(
          'Erro ao buscar dados da empresa pelo CNPJ: ${response.statusCode}');
      _showErrorSnackBar(
          'Erro ao buscar dados da empresa. Tente novamente mais tarde.');
    }
  }

  void _showErrorSnackBar(String message) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: AwesomeSnackbarContent(
        title: 'Erro',
        message: message,
        contentType: ContentType.failure,
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
          'Agenda',
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
      body: Column(
        children: [
          TableCalendar(
            focusedDay: now,
            firstDay: firstDay,
            lastDay: lastDay,
            availableCalendarFormats: const {
              CalendarFormat.month: 'mês',
              CalendarFormat.week: 'Semana',
              CalendarFormat.twoWeeks: '2 semanas'
            },
            headerStyle: const HeaderStyle(
              headerPadding: EdgeInsets.zero,
              formatButtonVisible: false,
              formatButtonShowsNext: false,
              titleCentered: true,
            ),
            calendarStyle: const CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: Color.fromARGB(255, 158, 224, 160),
                shape: BoxShape.circle,
              ),
              selectedTextStyle: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 1.0),
              ),
              todayDecoration: BoxDecoration(
                color: Color.fromARGB(255, 158, 224, 160),
                shape: BoxShape.circle,
              ),
            ),
            locale: 'pt_BR',
            onDaySelected: (selectedDay, focusedDay) {
              _showAgendamentoFormModal(context, selectedDay);
            },
          ),
        ],
      ),
    );
  }

  void _showAgendamentoFormModal(BuildContext context, DateTime selectedDay) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Gostaria de Agendar para ${selectedDay.day}/${selectedDay.month}/${selectedDay.year}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Formulário para dados da empresa
                  Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CustomTextField(
                          controller: cnpjController,
                          icon: Icons.format_list_numbered,
                          validator: cnpjvalidator,
                          label: 'CNPJ',
                          textInputType: TextInputType.number,
                          onFieldSubmitted: (value) {
                            if (cnpjController.text.isNotEmpty) {
                              _fetchCompanyDetails(cnpjController.text);
                            } else {
                              _showErrorSnackBar(
                                  'Digite um CNPJ válido! Verifique e tente novamente.');
                            }
                          },
                        ),
                        CustomTextField(
                          controller: centroDeFormacaoController,
                          icon: Icons.corporate_fare,
                          label: 'Centro de Formação',
                        ),
                        CustomTextField(
                          controller: tipoController,
                          icon: Icons.email,
                          label: 'Nome Fantasia',
                        ),
                        CustomTextField(
                          controller: tipoController,
                          icon: Icons.email,
                          label: 'Situação',
                        ),
                        CustomTextField(
                          controller: tipoController,
                          icon: Icons.email,
                          label: 'Tipo',
                        ),
                        CustomTextField(
                          controller: emailController,
                          icon: Icons.email,
                          label: 'Email',
                          validator: emailValidator,
                        ),
                        CustomTextField(
                            controller: cepController,
                            icon: Icons.location_on,
                            label: 'CEP:'),
                        CustomTextField(
                          controller: enderecoController,
                          icon: Icons.location_on,
                          label: 'Endereço',
                        ),
                        CustomTextField(
                          controller: numeroController,
                          icon: Icons.location_on,
                          label: 'Numero',
                        ),
                        CustomTextField(
                          controller: bairroController,
                          icon: Icons.location_on,
                          label: 'Bairro',
                        ),
                        CustomTextField(
                          controller: cidadeController,
                          icon: Icons.location_on,
                          label: 'Cidade',
                        ),
                        CustomTextField(
                          controller: estadoController,
                          icon: Icons.location_on,
                          label: 'Estado',
                        ),
                        CustomTextField(
                            controller: telefoneController,
                            icon: Icons.phone,
                            label: 'Telefone:'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final agendamento = ScheduleModel(
                        id: null,
                        centroDeFormacao: centroDeFormacaoController.text,
                        fantasia: tipoController.text,
                        situacao: tipoController.text,
                        cnpj: UtilBrasilFields.removeCaracteres(
                            cnpjController.text),
                        endereco: enderecoController.text,
                        data: selectedDay,
                        email: emailController.text,
                        cep: UtilBrasilFields.removeCaracteres(
                            cepController.text),
                        numero: numeroController.text,
                        bairro: bairroController.text,
                        cidade: cidadeController.text,
                        estado: estadoController.text,
                        telefone: UtilBrasilFields.removeCaracteres(
                            telefoneController.text),
                        tipo: tipoController.text,
                      );

                      widget.onAgendamentoSalvo(
                          agendamento); // Passa o agendamento para a tela principal
                      Navigator.pop(context); // Fecha o modal
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 106, 193, 145),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Salvar',
                      style: TextStyle(
                        color: Color.fromARGB(255, 248, 248, 248),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  List<ScheduleModel> agendamentos = [];

  void _adicionarAgendamento(ScheduleModel agendamento) {
    setState(() {
      agendamentos.add(agendamento); // Adiciona o agendamento à lista
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 106, 193, 145),
        title: const Text('Meus Agendamentos'),
      ),
      body: ListView.builder(
        itemCount: agendamentos.length,
        itemBuilder: (context, index) {
          final agendamento = agendamentos[index];
          return ListTile(
            title: Text(agendamento.centroDeFormacao),
            subtitle: Text('${agendamento.cnpj}\n${agendamento.endereco}'),
            trailing: Text(
                '${agendamento.data.day}/${agendamento.data.month}/${agendamento.data.year}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navega para a tela de agendamento e passa a função de callback
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AgendaTab(
                onAgendamentoSalvo:
                    _adicionarAgendamento, // Passa a função de salvar o agendamento
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
