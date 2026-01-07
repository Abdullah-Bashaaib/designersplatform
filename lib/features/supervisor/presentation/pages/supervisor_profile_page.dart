import 'package:designers_platform/core/current_user.dart';
import 'package:designers_platform/core/usecase/logout.dart';
import 'package:designers_platform/features/auth/data/repositories/auth_repository_imp.dart';
import 'package:designers_platform/features/auth/domain/repositories/auth_repository.dart';
import 'package:designers_platform/features/auth/presentation/pages/splash.dart';
import 'package:designers_platform/features/supervisor/presentation/getx/supervisor_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SupervisorProfilePage extends StatefulWidget {
  const SupervisorProfilePage({super.key});

  @override
  State<SupervisorProfilePage> createState() => _SupervisorProfilePageState();
}

class _SupervisorProfilePageState extends State<SupervisorProfilePage> {
  final controller = Get.find<SupervisorController>();

  @override
  void initState() {
    super.initState();
    // Pre-fill with current user data
    if (CurrentUser.currentUser != null) {
      controller.initProfile(
        CurrentUser.currentUser!.name,
        CurrentUser.currentUser!.phoneNumber.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الملف الشخصي للمشرف'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                LogoutUsecase l = LogoutUsecase(Get.find<AuthRepository>());
                l();
                Get.offAll(() => SplashScreen());
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: controller.updateFormKey,
          child: Column(
            children: [
              const SizedBox(height: 20),
              const CircleAvatar(
                radius: 50,
                child: Icon(Icons.person, size: 50),
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: controller.nameController,
                decoration: const InputDecoration(
                  labelText: 'الاسم',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person_outline),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال الاسم';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: controller.phoneController,
                decoration: const InputDecoration(
                  labelText: 'رقم الهاتف',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال رقم الهاتف';
                  }
                  if (!GetUtils.isPhoneNumber(value)) {
                    // Basic check, can be relaxed if needed
                    // return 'رقم الهاتف غير صحيح';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 40),
              Obx(() => SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: controller.isLoading.value
                          ? null
                          : () {
                              if (CurrentUser.currentUser != null) {
                                controller
                                    .updateProfile(CurrentUser.currentUser!.id);
                              }
                            },
                      child: controller.isLoading.value
                          ? const CircularProgressIndicator()
                          : const Text('حفظ التغييرات'),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
