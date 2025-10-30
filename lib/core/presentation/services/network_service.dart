import 'dart:async';
import 'dart:developer';

import 'package:designers_platform/core/utils/custom_dialog_getx.dart';
import 'package:get/get.dart';

import '../../domain/i_internet_info.dart';

class NetworkService extends GetxService {
  final INetworkInfo _networkInfo = Get.find<INetworkInfo>();
  late StreamSubscription _connectionSubscription;

  // هذه هي الحالة التفاعلية (Reactive State) التي سيراقبها التطبيق
  final isConnected = false.obs;

  @override
  void onInit() {
    super.onInit();
    log("✅ [NetworkService] onInit: Starting to listen..."); // <-- أضف هذا
    _listenToConnectionChanges();
  }

  /// يستمع للتغيرات ويحدّث الحالة
  void _listenToConnectionChanges() {
    _connectionSubscription = _networkInfo.onConnectionChanged.listen((status) {
      isConnected.value = status;

      // (اختياري) يمكنك إظهار SnackBar عالمي من هنا
      if (status) {
        DialogHelper.showSuccessSnackBar(
            title: "نجاح", message: "لديك اتصال انترنت");
      } else {
        DialogHelper.showWarningDialog(
            title: "تنبيه!!",
            message: "لا يوجد لديك اتصال انترنت!",
            buttonText: "حسنا");
      }
    });
  }

  /// جلب الحالة الأولية عند بدء تشغيل التطبيق (اختياري لكن مفضل)
  Future<void> checkInitialConnection() async {
    isConnected.value = await _networkInfo.isConnected;
  }

  @override
  void onClose() {
    // لا ننسى إغلاق الـ Stream
    _connectionSubscription.cancel();
    super.onClose();
  }
}
