import 'dart:developer';

// import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';

import 'package:designers_platform/core/current_user.dart';
import 'package:designers_platform/core/utils/custom_dialog_getx.dart';
import 'package:designers_platform/core/utils/messages.dart';
import 'package:designers_platform/features/designer_profile/domain/entities/review.dart';
import 'package:designers_platform/features/designer_profile/domain/usecases/review_usecase/add_review_use_case.dart';
import 'package:designers_platform/features/designer_profile/domain/usecases/review_usecase/get_review_use_case.dart';
import 'package:designers_platform/features/order_management/domain/entity/orders.dart';
import 'package:designers_platform/features/order_management/domain/usecase/delete_order.dart';
import 'package:designers_platform/features/order_management/domain/usecase/get_orders.dart';
import 'package:designers_platform/features/order_management/domain/usecase/get_supervisor_phone_usecase.dart';
import 'package:designers_platform/features/order_management/domain/usecase/update_order.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

class OrderGetx extends GetxController {
  final GetOrdersUsecase getOrdersUsecase;
  final DeleteOrderUsecase deleteOrderUsecase;
  final UpdateOrderUsecase updateOrderUsecase;
  final GetSupervisorPhoneUsecase supervisorPhoneUsecase;
  final AddReviewUseCase addReviewUseCase;
  final GetReviewUseCase getReviewUseCase;
  final Uuid uuid;
  // final NetworkService _networkService = Get.find<NetworkService>();

  OrderGetx(
    this.getOrdersUsecase,
    this.deleteOrderUsecase,
    this.updateOrderUsecase,
    this.supervisorPhoneUsecase,
    this.addReviewUseCase,
    this.uuid,
    this.getReviewUseCase,
  );

  var isLoading = false.obs;
  var isLoadingEdit = false.obs;
  var isLoadingSend = false.obs;
  var isLoadingFeedback = false.obs;

  var currentRating = 0.0.obs;
  var feedback = TextEditingController().obs;

  var orderList = <OrderEntity>[].obs;
  var reviewsList = <Review>[].obs;
  var reviewsByOrderId = <String, Review>{}.obs;

  @override
  void onInit() {
    super.onInit();
    log("----------> message: Current user is ${CurrentUser.currentUser?.name}");
    getOrders();
    getReviews();
  }

  Future<void> getOrders() async {
    if (CurrentUser.currentUser == null) {
      log('User not ready yet, skipping getOrders');
      return;
    }
    isLoading.value = true;
    String column = '';
    if (CurrentUser.currentUser!.role == 'عميل') {
      column = 'clientId';
    } else {
      column = 'designerId';
    }
    log(column);
    final result = await getOrdersUsecase(column);
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

  Future<void> sendPaymentViaWhatsApp(String orderId, String designType) async {
    isLoadingSend.value = true;
    // تحديث adminApproval إلى false
    final fields = {
      'id': orderId,
      'adminApproval': 'false',
    };

    await updateOrder(fields);

    final result = await supervisorPhoneUsecase();
    result.fold((f) {
      DialogHelper.showErrorSnackBar(
          title: 'خطأ', message: 'خطأ في جلب رقم المدير');
    }, (phoneNumber) async {
      final message = Uri.encodeComponent(
          'مرحباً، أود إرسال سند الدفع لطلبي : $designType');
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
    });
    isLoadingSend.value = false;
    // فتح واتساب

    // } catch (e) {
    //   log('Error in sendPaymentViaWhatsApp: $e');
    //   DialogHelper.showErrorSnackBar(
    //     title: 'خطأ',
    //     message: 'حدث خطأ أثناء فتح واتساب',
    //   );
    // }
  }

  Future<void> addReview(String designerId, String orderId) async {
    isLoadingFeedback.value = true;
    final review = Review(
        id: uuid.v4(),
        clientId: CurrentUser.currentUser!.id,
        designerId: designerId,
        nameClint: CurrentUser.currentUser!.name,
        orderId: orderId,
        feedback: feedback.value.text,
        timeReview: DateTime.now(),
        valueReview: currentRating.value);
    final result = await addReviewUseCase(review: review);
    result.fold(
      (l) {
        // print(l.message);
        DialogHelper.showErrorSnackBar(title: 'خطا', message: l.message);
      },
      (r) {
        DialogHelper.showSuccessSnackBar(
            title: 'نجاح', message: "تم التقييم بنجاح");
      },
    );
    isLoadingFeedback.value = false;
  }

  Future<void> getReviews() async {
    final result = await getReviewUseCase();
    result.fold(
      (l) {
        DialogHelper.showErrorSnackBar(title: 'خطا', message: globalError);
      },
      (r) {
        reviewsList.assignAll(r);
        reviewsByOrderId.assignAll({
          for (final review in reviewsList) review.orderId: review,
        });
        print(r.length);
      },
    );
  }

  double? getRate(String orderId) {
    return reviewsByOrderId[orderId]?.valueReview;
  }

  String? getFeedback(String orderId) {
    return reviewsByOrderId[orderId]?.feedback;
  }
}
