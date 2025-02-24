import 'package:get/get.dart';
import 'package:vistoria_cfc/src/pages/auth/view/sign_in_screen.dart';
import 'package:vistoria_cfc/src/pages/base/binding/navigation_binding.dart';
import 'package:vistoria_cfc/src/pages/base/view/base_screen.dart';
import 'package:vistoria_cfc/src/pages/home/binding/home_binding.dart';
import 'package:vistoria_cfc/src/pages/profile/binding/profile_binding.dart';
import 'package:vistoria_cfc/src/pages/splash/splash_screen.dart';
import 'package:vistoria_cfc/src/pages/vistoria/binding/vistoria_binding.dart';
import 'package:vistoria_cfc/src/pages/vistoria/view/vistoria_screen.dart';

abstract class AppPages {
  static final pages = <GetPage>[
    GetPage(
      page: () => VistoriaScreen(),
      name: PagesRoutes.vistoriaRoute,
    ),
    GetPage(
      page: () => const SplashScreen(),
      name: PagesRoutes.splashRoute,
    ),
    GetPage(
      page: () => SignInScreen(),
      name: PagesRoutes.signInRoute,
    ),
    GetPage(
      page: () => const BaseScreen(),
      name: PagesRoutes.baseRoute,
      bindings: [
        NavigationBinding(),
        HomeBinding(),
        VistoriaBinding(),
        // AgendaTabBinding(),
        ProfileBinding(),
      ],
    ),
  ];
}

abstract class PagesRoutes {
  static const String profileRoute = '/profile';
  static const String vistoriaRoute = '/vistoria';
  static const String signInRoute = '/signin';
  static const String signUpRoute = '/signup';
  static const String splashRoute = '/splash';
  static const String baseRoute = '/';
}
