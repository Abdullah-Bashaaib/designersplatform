import 'dart:developer';

import 'package:designers_platform/core/utils/custom_dialog_getx.dart';
import 'package:designers_platform/features/order_management/domain/entity/orders.dart';
import 'package:designers_platform/features/order_management/domain/usecase/get_orders.dart';
import 'package:get/get.dart';

class OrderGetx extends GetxController {
  final GetOrdersUsecase getOrdersUsecase;

  OrderGetx(this.getOrdersUsecase);

  var isLoading = false.obs;
  var orderList = <OrderEntity>[].obs;

  Future<void> getOrders() async {
    isLoading.value = true;
    final result = await getOrdersUsecase.call();
    result.fold((l) {
      DialogHelper.showErrorSnackBar(title: 'error', message: l.message);
      log(l.message);
    }, (r) {
      orderList.value = r;
    });
    isLoading.value = false;
  }
}
