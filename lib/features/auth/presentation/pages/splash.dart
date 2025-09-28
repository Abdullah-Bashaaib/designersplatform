import 'package:designers_platform/core/current_user.dart';
import 'package:designers_platform/core/usecase/get_user.dart';
import 'package:designers_platform/features/auth/domain/repositories/auth_repository.dart';
import 'package:designers_platform/features/auth/presentation/pages/welcome_page.dart';
import 'package:designers_platform/features/customer_profile/presentation/screens/view_profile.dart';
import 'package:designers_platform/features/designer_profile/presentation/views/screens/profile_screen.dart';
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

    final result = getUserUseCase.call();

    result.fold(
      (failure) {
        Get.offAll(() => const WelcomePage());
      },
      (user) {
        CurrentUser.currentUser = user;
        if (user.role == 'عميل') {
          Get.offAll(() => const ViewProfile());
        } else {
          Get.offAll(() => ProfileScreen());
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(), // شاشة تحميل مؤقتة
      ),
    );
  }
}
