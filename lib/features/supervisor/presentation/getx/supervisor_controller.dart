import 'package:designers_platform/core/utils/custom_dialog_getx.dart';
import 'package:designers_platform/core/utils/messages.dart';
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

  SupervisorController(
    this.getPendingOrdersUseCase,
    this.approveOrderUseCase,
    this.updateSupervisorProfileUseCase,
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

  void initProfile(String name, String phone) {
    nameController.text = name;
    phoneController.text = phone;
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
    final data = {
      'name': nameController.text.trim(),
      'phoneNumber': int.tryParse(phoneController.text.trim()) ?? 0,
    };

    final result = await updateSupervisorProfileUseCase(userId, data);
    result.fold(
      (failure) {
        DialogHelper.showErrorSnackBar(title: 'خطأ', message: failure.message);
      },
      (_) {
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
