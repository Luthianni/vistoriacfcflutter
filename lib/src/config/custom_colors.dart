import 'package:flutter/material.dart';

extension ThemeExtension on BuildContext {
  Color get cinzaVerdeEscuro => const Color.fromARGB(255, 109, 127, 136);
  Color get verdeTitulo => const Color.fromARGB(255, 106, 193, 145);
  Color get verdeTituloClaro => const Color.fromARGB(255, 64, 185, 140);
  Color get verdeCinzaCard => const Color.fromARGB(255, 193, 211, 194);
  Color get verdeCinzaCardClaro => const Color.fromARGB(255, 233, 242, 234);
  Color get badgeAlerta => const Color.fromARGB(255, 190, 93, 88);
  Color get badgeSucesso => const Color.fromARGB(255, 68, 155, 107);
  Color get badgeWarning => const Color.fromARGB(255, 192, 172, 58);
  Color get primaryColor => Theme.of(this).primaryColor;
  Color get primaryColorDark => Theme.of(this).primaryColorDark;
  Color get primaryColorLight => Theme.of(this).primaryColorLight;
  TextTheme get textTheme => Theme.of(this).textTheme;

  Color get primaryBlue => const Color(0xFF3F8CFF);
  Color get secondaryBlue => const Color(0xFFE5EDFF);
  Color get primaryGray => const Color(0xFFF5F5F5);
  Color get primaryGreen => const Color(0xFF42B58E);
  Color get secondaryGreen => const Color(0xFFE0FAEF);
  Color get primaryRed => const Color(0xFFFF3838); 
  Color get primaryText => const Color(0xFF3C5259);
  Color get secondaryText => const Color(0XFFA3A9AB);
  Color get primaryOrange => const Color(0xFFFFA500);
}
// Map<int, Color> _swatchOpacity = {
//   50: Colors.lightGreen[100]!,
//   100: Colors.lightGreen[200]!,
//   200: Colors.lightGreen[300]!,
//   300: Colors.lightGreen[400]!,
//   400: Colors.lightGreen[500]!,
//   500: Colors.lightGreen[600]!,
//   600: Colors.lightGreen[700]!,
//   700: Colors.lightGreen[800]!,
//   800: Colors.lightGreen[900]!,
// };

// abstract class CustomColors {
//   static Color customContrastColor = Colors.red.shade700;

//   static MaterialColor customSwatchColor = MaterialColor(
//     0xFF6AC191,
//     _swatchOpacity,
//   );
// }
