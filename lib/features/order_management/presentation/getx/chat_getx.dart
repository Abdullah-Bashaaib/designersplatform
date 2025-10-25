import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatOrderGetX extends GetxController {
  // .obs تجعل المتغير "تفاعليًا" (reactive)
  final _isOrderAccepted = false.obs;

  // getter عام للوصول إلى القيمة
  bool get isOrderAccepted => _isOrderAccepted.value;

  // بيانات الشات الوهمية
  late final List<String> chatMessages;
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    // تحضير البيانات عند بدء الـ controller
    chatMessages = List.generate(50, (index) => "رسالة رقم: $index");
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  // 3. الدوال لإدارة منطق الأعمال
  void acceptOrder() {
    _isOrderAccepted.value = true;
    // يمكنك إضافة أي منطق آخر هنا (مثل إرسال طلب للـ API)
  }

  void rejectOrder() {
    // كما طلبت، "سيخرج من الشاشة"

    Get.back(canPop: true);
    // يمكنك إظهار SnackBar هنا باستخدام Get.snackbar(...)
  }
}
