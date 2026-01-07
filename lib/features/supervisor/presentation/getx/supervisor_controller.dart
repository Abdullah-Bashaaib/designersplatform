import 'package:designers_platform/core/current_user.dart';
import 'package:designers_platform/core/usecase/get_user.dart';
import 'package:designers_platform/core/usecase/save_user.dart';
import 'package:designers_platform/core/utils/custom_dialog_getx.dart';
import 'package:designers_platform/core/utils/messages.dart';
import 'package:designers_platform/features/auth/domain/entities/user.dart';
import 'package:designers_platform/features/auth/domain/repositories/auth_repository.dart';
import 'package:designers_platform/features/order_management/domain/entity/orders.dart';
import 'package:designers_platform/features/supervisor/domain/usecases/approve_order.dart';
import 'package:designers_platform/features/supervisor/domain/usecases/get_pending_orders.dart';
import 'package:designers_platform/features/supervisor/domain/usecases/update_supervisor_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SupervisorController extends GetxController {
  final GetPendingOrdersUseCase getPendingOrdersUseCase;
  final ApproveOrderUseCase approveOrderUseCase;
  final UpdateSupervisorProfileUseCase updateSupervisorProfileUseCase;
  final SaveUserUsecase saveUserUsecases;

  SupervisorController(
    this.getPendingOrdersUseCase,
    this.approveOrderUseCase,
    this.updateSupervisorProfileUseCase,
    this.saveUserUsecases,
  );

  var isLoading = false.obs;
  var pendingOrders = <OrderEntity>[].obs;

  // Profile editing controllers
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final updateFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    getPendingOrders();
  }

  Future<void> initProfile(String name, String phone) async {
    final getUserUseCase = GetUserUseCase(Get.find<AuthRepository>());

    final result = await getUserUseCase();
    result.fold(
      (failure) {
        DialogHelper.showErrorSnackBar(title: 'خطأ', message: failure.message);
      },
      (user) {
        CurrentUser.currentUser = user;
        nameController.text = CurrentUser.currentUser!.name;
        phoneController.text = CurrentUser.currentUser!.phoneNumber.toString();
      },
    );
  }

  Future<void> getPendingOrders() async {
    isLoading.value = true;
    final result = await getPendingOrdersUseCase();
    result.fold(
      (failure) {
        DialogHelper.showErrorSnackBar(title: 'خطأ', message: failure.message);
      },
      (orders) {
        pendingOrders.value = orders;
      },
    );
    isLoading.value = false;
  }

  Future<void> approveOrder(String orderId) async {
    isLoading.value = true;
    final result = await approveOrderUseCase(orderId);
    result.fold(
      (failure) {
        DialogHelper.showErrorSnackBar(title: 'خطأ', message: failure.message);
      },
      (_) {
        DialogHelper.showSuccessSnackBar(
            title: 'نجاح', message: 'تم قبول الطلب بنجاح');
        // Refresh the list locally
        pendingOrders.removeWhere((order) => order.id == orderId);
      },
    );
    isLoading.value = false;
  }

  Future<void> updateProfile(String userId) async {
    if (!updateFormKey.currentState!.validate()) return;

    isLoading.value = true;
    final Map<String, dynamic> data = {
      'name': nameController.text.trim(),
      'phone_number': int.tryParse(phoneController.text.trim()) ?? 0,
    };

    final result = await updateSupervisorProfileUseCase(userId, data);
    result.fold(
      (failure) {
        DialogHelper.showErrorSnackBar(title: 'خطأ', message: failure.message);
        print(failure.message);
      },
      (_) {
        CurrentUser.currentUser!
            .copyWith(name: data['name'], phoneNumber: data['phoneNumber']);
        saveUserUsecases(CurrentUser.currentUser!);
        DialogHelper.showSuccessSnackBar(
            title: 'نجاح', message: 'تم تحديث الملف الشخصي بنجاح');
      },
    );
    isLoading.value = false;
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}
