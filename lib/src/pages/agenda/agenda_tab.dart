import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

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
          ),
        ],
      ),
    );
  }
}
