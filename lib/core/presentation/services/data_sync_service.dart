import 'dart:developer';

import 'package:get/get.dart';

// قم باستيراد الكنترولرز التي تريد تحديثها
import '../../../features/customer_profile/presentation/getx/client_profile_controller.dart';
import '../../../features/order_management/presentation/getx/order_getx.dart';
import 'network_service.dart';

class DataSyncService extends GetxService {
  final NetworkService _networkService = Get.find<NetworkService>();

  /// علم (Flag) لمنع "عاصفة الطلبات".
  /// نحن نريد التحديث "فقط" عندما نعود من حالة عدم الاتصال.
  bool _wasOffline = false;

  @override
  void onInit() {
    super.onInit();

    // هذا هو "اللسنر الذكي" الخاص بك
    // ever() هو GetX Worker يستمع لـ Rx variable
    ever(_networkService.isConnected, _handleConnectionChange);
  }

  /// هذه الدالة هي "قلب" المنطق
  void _handleConnectionChange(bool isOnline) {
    if (isOnline) {
      // إذا كان الاتصال "عاد" (أي أنه كان مقطوعاً)
      if (_wasOffline) {
        log("🔄 [DataSyncService] Reconnected. Triggering background sync...");

        // "Fire and forget" - لا نريد إيقاف الواجهة
        // _syncProfileData();
        _syncOrdersData();

        // أعد العلم إلى وضعه الطبيعي
        _wasOffline = false;
      }
    } else {
      // إذا "انقطع" الاتصال، قم برفع العلم
      log("🔌 [DataSyncService] Connection lost. Setting flag for sync on reconnect.");
      _wasOffline = true;
    }
  }

  /// دالة لجلب بيانات البروفايل
  void _syncProfileData() {
    // نستخدم "tryFind" لأنه قد لا يكون الكنترولر في الذاكرة بعد
    // أو استخدم Get.find() إذا كنت متأكداً أنه (permanent)
    final profileController = Get.find<ClientProfileController>();

    // (اختياري: منطق إضافي)
    // لا تقم بالجلب إذا كان الكنترولر "مشغولاً" أصلاً
    if (!profileController.isLoading.value) {
      profileController.getProfile(); // افترض أن هذه هي دالة الجلب
    }
  }

  /// دالة لجلب بيانات الطلبات
  void _syncOrdersData() {
    final orderController = Get.find<OrderGetx>();
    if (!orderController.isLoading.value) {
      // افترض أن لديك متغير isLoading
      orderController.getOrders(); // افترض أن هذه هي دالة الجلب
    }
  }
}
