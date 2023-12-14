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
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Agenda',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.green,
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
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              selectedTextStyle: TextStyle(color: Colors.white),
              todayDecoration: BoxDecoration(
                color: Colors.blue,
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


