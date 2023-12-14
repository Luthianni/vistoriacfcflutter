import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vistoria_cfc/src/pages/agenda/agenda_tab.dart';
import 'package:vistoria_cfc/src/pages/base/controller/navigation_controller.dart';
import 'package:vistoria_cfc/src/pages/home/Components/home_tab.dart';
import 'package:vistoria_cfc/src/pages/profile/profile_tab.dart';
import 'package:vistoria_cfc/src/pages/vistoria/vistoria_tab.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int currentIndex = 0;
  final navigationController = Get.find<NavigationController>();
  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: const [
          HomeTab(),
          VistoriaTab(),
          AgendaTab(),
          ProfileTab(),
        ],
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
              pageController.jumpToPage(index);
              pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeInOutQuart,
              );
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color.fromRGBO(38, 187, 55, 1.0),
          selectedItemColor: const Color.fromRGBO(255, 255, 255, 1.0),
          unselectedItemColor: const Color.fromRGBO(255, 255, 255, 0.392),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.article_outlined),
              label: 'Vistorias',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.date_range_outlined),
              label: 'Agenda',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_2_outlined),
              label: 'Perfil',
            ),
          ],
        ),
      ),
    );
  }
}
