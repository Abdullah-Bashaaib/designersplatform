import 'package:designers_platform/core/utils/app_colors.dart';
import 'package:designers_platform/features/auth/presentation/pages/welcome_page.dart';
import 'package:designers_platform/features/customer_profile/presentation/screens/update_profile_client.dart';
import 'package:designers_platform/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
            themeMode: ThemeMode.system,
            defaultTransition: Transition.cupertino,
            transitionDuration: const Duration(milliseconds: 400),
            home: WelcomePage());
      },
    );
  }
}
