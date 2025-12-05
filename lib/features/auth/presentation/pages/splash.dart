import 'package:designers_platform/core/current_user.dart';
import 'package:designers_platform/core/usecase/get_user.dart';
import 'package:designers_platform/features/auth/domain/repositories/auth_repository.dart';
import 'package:designers_platform/features/auth/presentation/pages/welcome_page.dart';
import 'package:designers_platform/features/home/presentation/pages/client_home_page.dart';
import 'package:designers_platform/features/order_management/presentation/pages/view_order.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkUser();
    });
  }

  void _checkUser() {
    final getUserUseCase = GetUserUseCase(Get.find<AuthRepository>());

    final result = getUserUseCase();

    result.fold(
      (failure) {
        Get.offAll(() => const WelcomePage());
      },
      (user) {
        CurrentUser.currentUser = user;
        if (user.role == 'عميل') {
          Get.offAll(() => const ClientHomePage());
        } else {
          Get.offAll(() => ViewOrder());
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
