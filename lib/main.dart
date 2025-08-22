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
        theme: ThemeData(
          colorScheme:
              ColorScheme.fromSeed(seedColor: Colors.deepPurple.shade900),
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple
                .shade900, // يمكنك اختيار لون بذرة مختلف للوضع المظلم
            brightness:
                Brightness.dark, // يضمن أن الألوان متوافقة مع الوضع المظلم
          ),
          useMaterial3: true,
        ),
        themeMode: ThemeMode.light,
        home: WelcomePage());
  }
}
