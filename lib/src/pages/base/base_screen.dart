import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vistoria_cfc/src/pages/agenda/view/agenda_tab.dart';
import 'package:vistoria_cfc/src/pages/base/controller/navigation_controller.dart';
import 'package:vistoria_cfc/src/pages/home/Components/home_tab.dart';
import 'package:vistoria_cfc/src/pages/profile/view/profile_tab.dart';
import 'package:vistoria_cfc/src/pages/vistoria/view/vistoria_tab.dart';

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
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: navigationController.pageController,
          children: const [
            HomeTab(),
            VistoriaTab(),
            AgendaTab(),
            ProfileTab(),
          ],
        ),
        bottomNavigationBar: Obx(
          () => ClipRRect(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(20.0)),
            child: BottomNavigationBar(
              currentIndex: navigationController.currentIndex,
              onTap: (index) {
                navigationController.navitePageView(index);
              },
              type: BottomNavigationBarType.fixed,
              backgroundColor: const Color.fromARGB(255, 106, 193, 145),
              selectedItemColor: const Color.fromRGBO(38, 187, 55, 1.0),
              unselectedItemColor: const Color.fromARGB(255, 248, 248, 248),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  label: 'Home',
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
                  label: 'perfil',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
