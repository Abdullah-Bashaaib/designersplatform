
import 'package:designers_platform/features/auth/presentation/getx/auth_controller.dart';
import 'package:designers_platform/injection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'features/auth/presentation/pages/login_page.dart';

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
      title: 'Designer Platform',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginPage(),
    );
  }
}
