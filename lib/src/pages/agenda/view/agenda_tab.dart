import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:vistoria_cfc/src/pages/common_widgets/custom_text_field.dart';
import 'package:vistoria_cfc/src/services/validators.dart';

var now = DateTime.now();
var firstDay = DateTime(now.year, now.month - 3, now.day);
var lastDay = DateTime(now.year, now.month + 3, now.day);

class AgendaTab extends StatefulWidget {
  const AgendaTab({super.key});

  @override
  State<AgendaTab> createState() => _AgendaTabSelectorState();
}

class _AgendaTabSelectorState extends State<AgendaTab> {
  CalendarFormat format = CalendarFormat.twoWeeks;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 158, 224, 160),
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
                    'Criar Agendamento para ${selectedDay.day}/${selectedDay.month}/${selectedDay.year}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Adicione aqui o seu formulário de criação de agendamento
                  const Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CustomTextField(
                          icon: Icons.corporate_fare,
                          label: 'Centro de Formação',
                        ),
                        CustomTextField(
                          icon: Icons.format_list_numbered,
                          label: 'CNPJ',
                          validator: cnpjvalidator,
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Lógica para salvar o agendamento
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
