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
import 'package:url_launcher/url_launcher.dart';

class OrderGetx extends GetxController {
  final GetOrdersUsecase getOrdersUsecase;
  final DeleteOrderUsecase deleteOrderUsecase;
  final UpdateOrderUsecase updateOrderUsecase;
  // final NetworkService _networkService = Get.find<NetworkService>();

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
    String column = '';
    if (CurrentUser.currentUser!.role == 'عميل') {
      column = 'clientId';
    } else {
      column = 'designerId';
    }
    log(column);
    final result = await getOrdersUsecase.call(column);
    result.fold((l) {
      DialogHelper.showErrorSnackBar(title: 'خطــــــــأ!', message: l.message);
      log(l.message);
    }, (r) {
      orderList.value = r;
    });
    isLoading.value = false;
  }

  Future<void> updateOrder(Map<String, dynamic> fields) async {
    log('message');
    isLoadingEdit.value = true;

    // نتأكد أن الـ fields تحتوي على المعرف المطلوب
    final orderId = fields['id'];
    if (orderId == null || orderId.toString().isEmpty) {
      DialogHelper.showErrorSnackBar(
        title: 'خطأ',
        message: 'لم يتم تمرير معرف الطلب!',
      );
      isLoadingEdit.value = false;
      return;
    }

    // نرسل الحقول كما هي إلى الـ usecase
    final result = await updateOrderUsecase(orderId, fields);

    result.fold(
      (f) => DialogHelper.showErrorSnackBar(
        title: 'خطأ',
        message: f.message,
      ),
      (r) {
        DialogHelper.showSuccessSnackBar(
          title: 'إنجاز!',
          message: updateOrderMessage,
        );
        // تحديث البيانات في القائمة المحلية
        if (orderList.isNotEmpty) {
          int index = orderList.indexWhere((o) => o.id == orderId);
          if (index != -1) {
            orderList[index].designType =
                fields['designType'] ?? orderList[index].designType;
            orderList[index].description =
                fields['description'] ?? orderList[index].description;
            orderList.refresh();
          }
        }
      },
    );

    isLoadingEdit.value = false;
  }

  Future<void> deleteOrder(String orderId) async {
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

  Future<void> saveDesign(String imageUrl) async {
    try {
      if (imageUrl.isNotEmpty) {
        DialogHelper.showInfoDialog(
            title: "جاري التحميل...", message: "الرجاء الانتظار");
        // await ImageDownloader.downloadImage(imageUrl);
        DialogHelper.showSuccessSnackBar(
            title: "تم التحميل", message: "تم تنزيل الصورة بنجاح");
      }
    } catch (e) {
      DialogHelper.showErrorSnackBar(
          title: 'خطــأ!', message: 'تعذر تنزيل الصورة');
    }
  }

  /// فتح واتساب لإرسال سند الدفع وتحديث adminApproval إلى false
  Future<void> sendPaymentViaWhatsApp(
      String orderId) async {
    try {
      // تحديث adminApproval إلى false
      final fields = {
        'id': orderId,
        'adminApproval': 'false',
      };

      await updateOrder(fields);
      

      // فتح واتساب
      final message = Uri.encodeComponent(
          'مرحباً، أود إرسال سند الدفع للطلب رقم: $orderId');
      final whatsappUrl = 'https://wa.me/$phoneNumber?text=$message';

      final uri = Uri.parse(whatsappUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        DialogHelper.showErrorSnackBar(
          title: 'خطأ',
          message: 'لا يمكن فتح واتساب على هذا الجهاز',
        );
      }
    } catch (e) {
      log('Error in sendPaymentViaWhatsApp: $e');
      DialogHelper.showErrorSnackBar(
        title: 'خطأ',
        message: 'حدث خطأ أثناء فتح واتساب',
      );
    }
  }
}
