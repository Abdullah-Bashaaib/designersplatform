import 'package:designers_platform/core/routes/app_routes.dart';
import 'package:designers_platform/core/utils/app_colors.dart';
import 'package:designers_platform/features/auth/presentation/pages/splash.dart';
import 'package:designers_platform/features/order_management/presentation/pages/chat_order.dart';
import 'package:designers_platform/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'features/order_management/presentation/bindings/chat_binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ar');
  await Supabase.initialize(
      url: 'https://lkqdlophafsybtuwiqfd.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxrcWRsb3BoYWZzeWJ0dXdpcWZkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTk1MDU1OTksImV4cCI6MjA3NTA4MTU5OX0.ybh93Vx7JjLb7DiqgZJJIBkwOMl-f-fc3UoLI69aRMU',
      authOptions: FlutterAuthClientOptions(autoRefreshToken: true));
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
          getPages: [
            GetPage(
              name: AppRoutes.chat,
              page: () => ChatOrder(order: order), //!  Stopped Here
              binding: ChatBinding(),
            )
          ],
          home: SplashScreen(),
        );
      },
    );
  }
}
