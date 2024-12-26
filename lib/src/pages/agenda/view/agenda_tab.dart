import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:vistoria_cfc/src/models/schedule_model.dart';
import 'package:vistoria_cfc/src/pages/common_widgets/custom_text_field.dart';
import 'package:vistoria_cfc/src/services/validators.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';

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

  final TextEditingController centroDeFormacaoController = TextEditingController();
  final TextEditingController cnpjController = TextEditingController();
  final TextEditingController inscricaoEstadualController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController cepController = TextEditingController();
  final TextEditingController enderecoController = TextEditingController();
  final TextEditingController numeroController = TextEditingController();
  final TextEditingController bairroController = TextEditingController();
  final TextEditingController cidadeController = TextEditingController();
  final TextEditingController estadoController = TextEditingController();
  final TextEditingController telefoneController = TextEditingController(); 
  final TextEditingController celularController = TextEditingController();    

  final Logger logger = Logger();

  Future<void> _fetchAddress(String cep) async {
    logger.i('Buscando o endereço pelo Cep: $cep');
    final response = await http.get(Uri.parse('https://viacep.com.br/ws/$cep/json/'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        enderecoController.text = data['logradouro'] ?? '';
        bairroController.text = data['bairro'] ?? '';
        cidadeController.text = data['localidade'] ?? '';
        estadoController.text = data['uf'] ?? '';
      });
    } else {
      logger.e('Falha ao verificar endereço pelo CEP: $cep');
      Get.snackbar('Erro', 'Falha ao buscar endereço');
    }
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
                          controller: centroDeFormacaoController,
                          icon: Icons.corporate_fare,
                          label: 'Centro de Formação de Condutores',
                        ),
                        CustomTextField(
                          controller: cnpjController,
                          icon: Icons.format_list_numbered,
                          label: 'CNPJ',
                          validator: cnpjvalidator,
                        ),
                        CustomTextField(
                          controller: inscricaoEstadualController,
                          icon: Icons.location_on,
                          label: 'Inscrição Estadual', 
                          validator: inscricaoEstadualValidator,                                                   
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
                          label: 'Cep',
                          onChanged: (value) {
                            if (value.length == 8) {
                              _fetchAddress(value);
                            }
                          },
                        ),
                        CustomTextField(
                          controller: enderecoController,
                          icon: Icons.location_on,
                          label: 'Endereço',                                                   
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
                          label: 'Telefone',                                                   
                        ),
                        CustomTextField(
                          controller: celularController,
                          icon: Icons.phone_android,
                          label: 'Celular',                                                   
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final agendamento = ScheduleModel(
                        centroDeFormacao: centroDeFormacaoController.text,
                        cnpj: cnpjController.text,
                        endereco: enderecoController.text,
                        data: selectedDay, 
                        inscricaoEstadual: inscricaoEstadualController.text,
                        email: emailController.text,
                        cep: cepController.text,
                        numero: numeroController.text,
                        bairro: bairroController.text,
                        cidade: cidadeController.text,
                        estado: estadoController.text,
                        telefone: telefoneController.text,
                        celular: celularController.text,
                      );

                      widget.onAgendamentoSalvo(agendamento); // Passa o agendamento para a tela principal
                      Navigator.pop(context); // Fecha o modal
                    },
                    child: const Text('Salvar'),
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
            trailing: Text('${agendamento.data.day}/${agendamento.data.month}/${agendamento.data.year}'),
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
                onAgendamentoSalvo: _adicionarAgendamento, // Passa a função de salvar o agendamento
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}