import 'package:designers_platform/core/utils/app_colors.dart';
import 'package:designers_platform/features/auth/presentation/pages/welcome_page.dart';
import 'package:designers_platform/injection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Injection.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Designer Platform',
        locale: Get.deviceLocale,
        theme: AppThemes.lightTheme,
        darkTheme: AppThemes.darkTheme,
        themeMode: ThemeMode.system,
        home: WelcomePage());
  }
}
