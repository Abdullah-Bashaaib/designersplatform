import 'package:designers_platform/core/database/sqflite_helper.dart';
import 'package:designers_platform/core/utils/app_colors.dart';
import 'package:designers_platform/firebase_options.dart';
import 'package:designers_platform/injection.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'features/auth/presentation/pages/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Injection.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Designer Platform',
          locale: Get.deviceLocale,
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          themeMode: ThemeMode.dark,
          defaultTransition: Transition.cupertino,
          transitionDuration: const Duration(milliseconds: 400),
          home: SplashScreen(),
        );
      },
    );
  }
}
