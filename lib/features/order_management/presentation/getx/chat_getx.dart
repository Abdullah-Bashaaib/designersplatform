import 'dart:async';
import 'dart:developer';

import 'package:designers_platform/core/current_user.dart';
import 'package:designers_platform/core/utils/key_app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entity/chat_room.dart';
import '../../domain/entity/orders.dart';
import '../../domain/usecase/chat_room/get_chat_messages_usecase.dart';
import '../../domain/usecase/chat_room/send_message_useCase.dart';

class ChatOrderGetX extends GetxController {
  final SharedPreferences preferences;
  final GetChatMessagesUseCase _getMessagesUseCase;
  final SendMessageUseCase _sendMessageUseCase; // 💡
  final Uuid _uuid; // 💡
  final OrderEntity order; // لتخزين الطلب الحالي

  ChatOrderGetX(this.preferences, this._getMessagesUseCase,
      this._sendMessageUseCase, this._uuid,
      {required this.order});
  // .obs تجعل المتغير "تفاعليًا" (reactive)
  final _isOrderAccepted = false.obs;

  final RxList<Message> chatMessages = <Message>[].obs;
  late StreamSubscription<List<Message>> _chatSubscription;

  late String _currentUserId;

  final scrollController = ScrollController();
  final textController = TextEditingController(); // 💡 لإدخال النص

  // getter عام للوصول إلى القيمة
  bool get isOrderAccepted => _isOrderAccepted.value;

  @override
  void onInit() {
    super.onInit();
    // تحضير البيانات عند بدء الـ controller
    checkAccept();
    _currentUserId = CurrentUser.currentUser!.id; // (مثال)
    log("message: Order ID is ${order.id}");
    _listenToMessages(order.id); // افترض أن ID الطلب هو ID الشات
  }

  @override
  void onClose() {
    _chatSubscription.cancel();
    scrollController.dispose();
    textController.dispose();
    super.onClose();
  }

  // 3. الدوال لإدارة منطق الأعمال
  void acceptOrder() {
    _isOrderAccepted.value = true;
    preferences.setString(
      KeySharedPref.kAcceptOrder,
      _isOrderAccepted.toString(),
    );
  }

  void rejectOrder() {
    Get.back(canPop: true);
  }

  void checkAccept() {
    final value = preferences.getString(KeySharedPref.kAcceptOrder);
    log("message: Accepted Value in SharedPref is \"$value\"");
    if (value == null) {
      _isOrderAccepted.value = value == 'false';
    } else {
      _isOrderAccepted.value = value == 'true';
    }
  }

  void _listenToMessages(String chatId) {
    _chatSubscription = _getMessagesUseCase(chatId).listen((messages) {
      chatMessages.assignAll(messages);
      _scrollToBottom();
    }, onError: (e) {
      Get.snackbar("خطأ", "فشل تحميل الرسائل");
    });
  }

  // --- 💡 دالة إرسال الرسالة ---
  Future<void> sendMessage() async {
    final content = textController.text.trim();
    if (content.isEmpty) return;

    final messageId = _uuid.v4();
    final message = Message(
      id: messageId,
      chatId: order.id, // ID الشات
      senderId: _currentUserId,
      content: content,
      timestamp: DateTime.now(),
      type: MessageType.text,
    );

    textController.clear(); // مسح الحقل فوراً

    try {
      // إرسال الرسالة (هذا سيقوم بتحديث الـ Stream أوتوماتيكياً)
      _sendMessageUseCase(message.content);
      // (الـ UseCase هذا يجب أن يقوم أيضاً بتحديث "ملخص" الـ Chat entity)
    } catch (e) {
      Get.snackbar("خطأ", "فشل إرسال الرسالة");
      // (يمكن إعادة النص للحقل ليعيد المستخدم إرساله)
      textController.text = content;
    }
  }

  bool isMessageFromMe(Message message) {
    return message.senderId == _currentUserId;
  }

  void _scrollToBottom() {/* ... */}
}
