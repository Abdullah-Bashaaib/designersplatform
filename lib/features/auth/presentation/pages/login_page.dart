import 'package:designers_platform/features/auth/presentation/getx/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final emilC = TextEditingController();
  final passwordC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();
    return Scaffold(
      appBar: AppBar(
        title: Text('منصة المصممين'),
      ),
      body: Center(
        child: Text('no data'),
      ),
    );
  }
}
