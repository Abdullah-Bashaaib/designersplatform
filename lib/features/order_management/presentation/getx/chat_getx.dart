import 'dart:async';

import 'package:get/get.dart';

import '../../domain/entity/chat_room.dart';
import '../../domain/usecase/chat_room/close_chat_room_use_case.dart';
import '../../domain/usecase/chat_room/create_chat_room_usecase.dart';
import '../../domain/usecase/chat_room/get_chat_room_by_orderId_usecase.dart';
import '../../domain/usecase/chat_room/send_message_use_case.dart';
import '../../domain/usecase/chat_room/subscribe_to_messages_use_case.dart';
import '../../domain/usecase/chat_room/update_last_read_use_case.dart';

class ChatController extends GetxController {
  // UseCases
  final CreateChatRoomUseCase createChatRoom;
  final GetChatRoomByOrderIdUseCase getChatRoomByOrderId;
  final SubscribeToMessagesUseCase subscribeToMessages;
  final SendMessageUseCase sendMessage;
  final UpdateLastReadUseCase updateLastRead;
  final CloseChatRoomUseCase closeChatRoom;

  ChatController({
    required this.createChatRoom,
    required this.getChatRoomByOrderId,
    required this.subscribeToMessages,
    required this.sendMessage,
    required this.updateLastRead,
    required this.closeChatRoom,
  });

  // State
  final Rxn<ChatRoom> chatRoom = Rxn<ChatRoom>();
  final RxList<ChatMessage> messages = <ChatMessage>[].obs;
  final RxBool isLoading = false.obs;

  StreamSubscription<List<ChatMessage>>? _messagesSub;

  // ------------------------------------------
  // Init chat by order
  // ------------------------------------------
  Future<void> initChat({
    required String orderId,
    required String clientId,
    required String designerId,
    required bool isClient,
  }) async {
    isLoading.value = true;

    try {
      chatRoom.value = await getChatRoomByOrderId(orderId);

      // إنشاء الشات لو غير موجود
      if (chatRoom.value == null) {
        chatRoom.value = await createChatRoom(
          orderId: orderId,
          clientId: clientId,
          designerId: designerId,
        );
      }

      // الاشتراك في الرسائل
      _subscribeToMessages();

      // تحديث القراءة
      await updateLastRead(
        chatRoomId: chatRoom.value!.id,
        isClient: isClient,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // ------------------------------------------
  // Subscribe to realtime messages
  // ------------------------------------------
  void _subscribeToMessages() {
    _messagesSub?.cancel();

    _messagesSub = subscribeToMessages(chatRoom.value!.id).listen(
      (data) {
        messages.assignAll(data);
      },
    );
  }

  // ------------------------------------------
  // Send message
  // ------------------------------------------
  Future<void> sendTextMessage(String text) async {
    if (text.trim().isEmpty) return;
    if (chatRoom.value?.canSendMessage() == false) return;

    await sendMessage(
      chatRoomId: chatRoom.value!.id,
      content: text.trim(),
    );
  }

  // ------------------------------------------
  // Close chat (order delivered)
  // ------------------------------------------
  Future<void> closeChat() async {
    if (chatRoom.value == null) return;

    await closeChatRoom(chatRoom.value!.id);
    chatRoom.value = chatRoom.value!.copyWith(
      isClosed: true,
      closedAt: DateTime.now(),
    );
  }

  @override
  void onClose() {
    _messagesSub?.cancel();
    super.onClose();
  }
}
