import 'dart:developer';
// import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';

import 'package:designers_platform/core/current_user.dart';
import 'package:designers_platform/core/utils/custom_dialog_getx.dart';
import 'package:designers_platform/core/utils/messages.dart';
import 'package:designers_platform/features/order_management/domain/entity/orders.dart';
import 'package:designers_platform/features/order_management/domain/usecase/delete_order.dart';
import 'package:designers_platform/features/order_management/domain/usecase/get_orders.dart';
import 'package:designers_platform/features/order_management/domain/usecase/update_order.dart';
import 'package:get/get.dart';

import '../../../../core/presentation/services/network_service.dart';

class OrderGetx extends GetxController {
  final GetOrdersUsecase getOrdersUsecase;
  final DeleteOrderUsecase deleteOrderUsecase;
  final UpdateOrderUsecase updateOrderUsecase;
  final NetworkService _networkService = Get.find<NetworkService>();

  OrderGetx(
      this.getOrdersUsecase, this.deleteOrderUsecase, this.updateOrderUsecase);

  var isLoading = false.obs;
  var isLoadingEdit = false.obs;
  var orderList = <OrderEntity>[].obs;
  @override
  void onInit() {
    super.onInit();
    log("----------> message: Current user is ${CurrentUser.currentUser?.name}");
    getOrders();
  }

  Future<void> getOrders() async {
    isLoading.value = true;
    final result = await getOrdersUsecase.call();
    result.fold((l) {
      DialogHelper.showErrorSnackBar(title: 'خطــــــــأ!', message: l.message);
      log(l.message);
    }, (r) {
      orderList.value = r;
    });
    isLoading.value = false;
  }

  Future<void> updateOrder(
      String orderId, String type, String description) async {
    log('message');
    isLoadingEdit.value = true;
    final result = await updateOrderUsecase.call(orderId, type, description);
    result.fold(
        (f) =>
            DialogHelper.showErrorSnackBar(title: 'خطــأ', message: f.message),
        (r) {
      DialogHelper.showSuccessSnackBar(
          title: "نجـاح!", message: updateOrderMessage);
      if (orderId.isNotEmpty) {
        int index = orderList.indexWhere((o) => o.id == orderId);
        if (index != 1) {
          orderList[index].designType = type;
          orderList[index].description = description;
          orderList.refresh();
        }
      }
    });
    isLoadingEdit.value = false;
  }

  Future<void> deleteOrder(String orderId) async {
    print('object');
    isLoading.value = true;
    final result = await deleteOrderUsecase.call(orderId);
    result.fold(
        (f) =>
            DialogHelper.showErrorSnackBar(title: 'error', message: f.message),
        (u) async {
      orderList.removeWhere((o) => o.id == orderId);
      Get.back();
      DialogHelper.showSuccessSnackBar(
          title: 'ok', message: deleteOrderMessage);
    });
    isLoading.value = false;
  }
}
