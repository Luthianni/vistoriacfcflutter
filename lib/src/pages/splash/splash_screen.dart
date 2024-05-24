import 'package:flutter/material.dart';
import 'package:vistoria_cfc/src/config/custom_colors.dart';
import 'package:vistoria_cfc/src/pages/common_widgets/app_name_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
