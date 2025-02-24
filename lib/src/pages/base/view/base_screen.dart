import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vistoria_cfc/src/pages/agenda/view/agenda_tab.dart';
import 'package:vistoria_cfc/src/pages/base/controller/navigation_controller.dart';
import 'package:vistoria_cfc/src/pages/cfc/view/cfc_tab.dart';
import 'package:vistoria_cfc/src/pages/profile/view/profile_tab.dart';
import 'package:vistoria_cfc/src/pages/vistoria/view/vistoria_tab.dart';
import 'package:vistoria_cfc/src/models/schedule_model.dart'; // Ensure this import exists

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final NavigationController navigationController =
      Get.find<NavigationController>();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Scaffold(
        body: Obx(() {
          return PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: navigationController.pageController,
            children: [
              const HomeTab(),
              const CfcTab(),
              const VistoriaTab(),
              AgendaTab(
                onAgendamentoSalvo: (ScheduleModel schedule) {},
              ),
              ProfileTab(),
            ],
          );
        }),
        bottomNavigationBar: Obx(() {
          return ClipRRect(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(20.0)),
            child: BottomNavigationBar(
              currentIndex: navigationController.currentIndex,
              onTap: (index) {
                navigationController.navigatePageView(index);
              },
              type: BottomNavigationBarType.fixed,
              backgroundColor: const Color.fromRGBO(255, 255, 255, 1.0),
              selectedItemColor: const Color.fromRGBO(38, 187, 55, 1.0),
              unselectedItemColor: const Color.fromARGB(255, 109, 127, 136),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.car_rental_outlined),
                  label: 'CFC',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.auto_stories_outlined),
                  label: 'Vistoria',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_month_outlined),
                  label: 'Agenda',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline),
                  label: 'Perfil',
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
