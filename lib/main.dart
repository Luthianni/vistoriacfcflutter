import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vistoria_cfc/src/pages/auth/controller/auth_controller.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:vistoria_cfc/src/pages/profile/controller/profile_controller.dart';
import 'package:vistoria_cfc/src/pages/schedule/controller/schedule_controller.dart';
import 'package:vistoria_cfc/src/pages_routes/app_pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Get.lazyPut(() => ProfileController());
  Get.put(EnhancedAuthController());
  Get.put(ScheduleController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: const [
        Locale('pt', 'BR'),
        Locale('en', 'US'),
      ],
      title: 'CFC Vistória',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: const Color.fromRGBO(255, 255, 255, 1.0),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: PagesRoutes.splashRoute,
      getPages: AppPages.pages,
    );
  }
}