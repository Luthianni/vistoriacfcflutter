import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vistoria_cfc/src/pages/agenda/agenda_tab.dart';
import 'package:vistoria_cfc/src/pages/base/controller/navigation_controller.dart';
import 'package:vistoria_cfc/src/pages/home/Components/home_tab.dart';
import 'package:vistoria_cfc/src/pages/profile/view/profile_tab.dart';
import 'package:vistoria_cfc/src/pages/vistoria/vistoria_tab.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final navigationController = Get.find<NavigationController>();
  final pageController = PageController();
  late final _BaseScreenController controller;

  @override
  void initState() {
    super.initState();
    controller = _BaseScreenController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildPageView(),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  Widget buildPageView() {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: pageController,
      children: const [
        HomeTab(),
        VistoriaTab(),
        AgendaTab(),
        ProfileTab(),
      ],
    );
  }

  Widget buildBottomNavigationBar() {
    return GetBuilder<_BaseScreenController>(
      init: controller,
      builder: (_) => BottomNavigationBar(
        currentIndex: controller.currentIndex.value,
        onTap: (index) {
          controller.currentIndex(index);
          pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOutQuart,
          );
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
    );
  }
}

class _BaseScreenController extends GetxController {
  final RxInt currentIndex = 0.obs;

  @override
  void onClose() {
    // Executado quando o controller é descartado
    super.onClose();
  }
}
