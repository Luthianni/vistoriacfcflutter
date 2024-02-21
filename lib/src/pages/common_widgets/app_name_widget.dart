import 'package:flutter/material.dart';

class AppNameWidget extends StatelessWidget {
  final Color? greenTitleColor;
  final double textSize;

  const AppNameWidget({
    Key? key,
    this.greenTitleColor,
    this.textSize = 30,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset('assets/fundo_device.png', fit: BoxFit.cover),
      ],
    );
  }
}
