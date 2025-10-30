import 'dart:developer';

import 'package:designers_platform/core/utils/custom_dialog_getx.dart';
import 'package:designers_platform/features/order_management/domain/entity/orders.dart';
import 'package:designers_platform/features/order_management/domain/usecase/get_orders.dart';
import 'package:get/get.dart';

import '../../../../core/presentation/services/network_service.dart';

class OrderGetx extends GetxController {
  final GetOrdersUsecase getOrdersUsecase;
  final NetworkService _networkService = Get.find<NetworkService>();

  OrderGetx(this.getOrdersUsecase);

  var isLoading = false.obs;
  var orderList = <OrderEntity>[].obs;
  @override
  void onInit() {
    super.onInit();
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
}
