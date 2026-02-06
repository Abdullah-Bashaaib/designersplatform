import 'dart:async';
import 'dart:developer';

import 'package:designers_platform/core/current_user.dart';
import 'package:designers_platform/core/utils/custom_dialog_getx.dart';
import 'package:designers_platform/features/order_management/data/models/chat_room_model.dart';
import 'package:designers_platform/features/order_management/presentation/getx/order_getx.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entity/chat_room.dart';
import '../../domain/entity/orders.dart';
import '../../domain/usecase/chat_room/get_chat_messages_usecase.dart';
import '../../domain/usecase/chat_room/send_message_useCase.dart';
import '../../domain/usecase/get_order_status_usecase.dart';

class ChatOrderGetX extends GetxController {
  final SharedPreferences preferences;
  final OrderGetx orderGetx;
  final GetChatMessagesUseCase _getMessagesUseCase;
  final SendMessageUseCase _sendMessageUseCase; // 💡
  final GetOrderStatusUseCase _getOrderStatusUseCase; // 🆕
  final Uuid _uuid; // 💡

  ChatOrderGetX(
    this.preferences,
    this._getMessagesUseCase,
    this._sendMessageUseCase,
    this._uuid,
    this.orderGetx,
  );
  // .obs تجعل المتغير "تفاعليًا" (reactive)
  final _isOrderAccepted = false.obs;
  final order = Rxn<OrderEntity>(); // لتخزين الطلب الحالي

  final RxList<Message> chatMessages = <Message>[].obs;
  late StreamSubscription<List<Message>> _chatSubscription;

  // late String _currentUserId;

  final scrollController = ScrollController();
  final textController = TextEditingController(); // 💡 لإدخال النص

  // getter عام للوصول إلى القيمة
  bool get isOrderAccepted => _isOrderAccepted.value;
  var acceptedLoading = false.obs;
  final c = Get.find<OrderGetx>();

  @override
  void onInit() {
    super.onInit();
    // تحضير البيانات عند بدء الـ controller
    checkAccept();
    // if (CurrentUser.currentUser!.id != null) {
    //   _currentUserId = CurrentUser.currentUser!.id; // (مثال)
    // }
    // _listenToMessages(order.value?.id ?? ''); // افترض أن ID الطلب هو ID الشات
  }

  @override
  void onClose() {
    _chatSubscription.cancel();
    scrollController.dispose();
    textController.dispose();
    super.onClose();
  }

  // 3. الدوال لإدارة منطق الأعمال
  void acceptOrder({required String id}) {
    acceptedLoading.value = true;
    _isOrderAccepted.value = true;
    final status = 'مقبول';
    orderGetx.updateOrder({'id': id, 'status': status});
    orderAcceptList
        .add({'orderId': id, 'acceptOrder': _isOrderAccepted.toString()});
    updateOrderStatus(orderId: id, newStatus: status);
    preferences.setString(
      KeySharedPref.kAcceptOrder,
      jsonEncode(orderAcceptList),
    );
    log("message: order list to string in chat getx : ${orderAcceptList.toString()}");
    acceptedLoading.value = false;
  }

  void rejectOrder() {
    Get.back(canPop: true);
  }

  String acceptedOrderTest(String value) {
    final List<Map<String, dynamic>> orderAcceptedJson =
        List<Map<String, dynamic>>.from(jsonDecode(value));

    int index = orderAcceptedJson.indexWhere((orderTest) {
      return (orderTest['orderId'] == order.value?.id &&
          orderTest['acceptOrder'] == 'true');
    });
    log("message: order json is ${orderAcceptedJson[index]['acceptOrder']}");

    return orderAcceptedJson[index]['acceptOrder'];
  }

  /// للتوافق مع الإصدارات السابقة - استخدم checkOrderStatusFromSupabase بدلاً منها
  @Deprecated('Use checkOrderStatusFromSupabase instead')
  void checkAccept() {
    log("message: order list to string in chat getx : ${orderAcceptList.toString()}");
    String? value = preferences.getString(KeySharedPref.kAcceptOrder);
    try {
      if (value == null) {
        _isOrderAccepted.value = value == 'false';
        throw Exception('لم يتم قبول الطلب');
      }
      value = acceptedOrderTest(value);
      _isOrderAccepted.value = value == 'true';
      order.value?.status = 'مقبول';
      log("message: Accepted Value in SharedPref is \"$value\"");
    } catch (e) {
      DialogHelper.showErrorSnackBar(
          title: "خطأ", message: "message: ${e.toString()}");
    }
  }

  // void _listenToMessages(String chatId) {
  //   _chatSubscription = _getMessagesUseCase(chatId).listen((messages) {
  //     chatMessages.assignAll(messages);
  //     _scrollToBottom();
  //   }, onError: (e) {
  //     Get.snackbar("خطأ", "فشل تحميل الرسائل");
  //   });
  // }

  // --- 💡 دالة إرسال الرسالة ---
  Future<void> sendMessage({required String chatId}) async {
    log("message: Here we Gooooo");
    final content = textController.text.trim();
    log("message: content is ${content.isEmpty}");
    if (content.isEmpty) return;

    final messageId = _uuid.v4();
    final message = MessageModel(
      id: messageId,
      chatId: chatId, // ID الشات
      senderId: CurrentUser.currentUser!.id,
      content: content,
      timestamp: DateTime.now(),
      type: MessageType.text, readBy: [],
    );

    textController.clear(); // مسح الحقل فوراً

    try {
      log("message: R u Here");
      // إرسال الرسالة (هذا سيقوم بتحديث الـ Stream أوتوماتيكياً)
      final result = await _sendMessageUseCase(message);
      result.fold(
        (l) {
          print(l.message);
        },
        (r) {
          print('ok');
        },
      );
      // (الـ UseCase هذا يجب أن يقوم أيضاً بتحديث "ملخص" الـ Chat entity)
    } catch (e) {
      Get.snackbar("خطأ", "فشل إرسال الرسالة");
      // (يمكن إعادة النص للحقل ليعيد المستخدم إرساله)
      textController.text = content;
    }
    log("message: we finish");
  }

  bool isMessageFromMe(Message message) {
    return message.senderId == CurrentUser.currentUser!.id;
  }

  void _scrollToBottom() {/* ... */}

  void updateOrderStatus({
    required String orderId,
    required String newStatus,
  }) {
    final index = c.orderList.indexWhere((o) => o.id == orderId);

    if (index == -1) return;

    c.orderList[index].status = newStatus;

    c.orderList.refresh(); // مهم جدًا أحيانًا
  }
}
