import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vistoria_cfc/src/config/custom_colors.dart';
import 'package:vistoria_cfc/src/pages/common_widgets/app_name_widget.dart';
import 'package:vistoria_cfc/src/pages_routes/app_pages.dart';
// Importe as rotas

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  Future<void> initializeResources() async {
    // Inicialize recursos aqui
    await Future.delayed(const Duration(seconds: 1)); // Simulação
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () async {
      await initializeResources();
      Get.offNamed(PagesRoutes.signInRoute); // ou PagesRoutes.signInRoute
    });

    return Material(
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              context.primaryGreen,
              context.primaryGreen.withAlpha(0xFF42B58E),
            ],
          ),
        ),
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppNameWidget(
              greenTitleColor: Color.fromRGBO(255, 106, 193, 145),
              textSize: 40,
            ),
          ],
        ),
      ),
    );
  }
}
