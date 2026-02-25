import 'dart:async';
import 'dart:developer';

import 'package:designers_platform/features/order_management/domain/usecase/chat_room/upload_file_use_case.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/utils/custom_dialog_getx.dart';
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
  final UploadFileUseCase uploadFileUseCase;

  ChatController(
      {required this.createChatRoom,
      required this.getChatRoomByOrderId,
      required this.subscribeToMessages,
      required this.sendMessage,
      required this.updateLastRead,
      required this.closeChatRoom,
      required this.uploadFileUseCase});

  // State
  final Rxn<ChatRoom> chatRoom = Rxn<ChatRoom>();
  final RxList<ChatMessage> messages = <ChatMessage>[].obs;
  final RxBool isLoading = false.obs;

  StreamSubscription<List<ChatMessage>>? _messagesSub;
  late final String _currentUserId;

  // ------------------------------------------
  // Init chat by order
  // ------------------------------------------
  Future<void> initChat({
    required String orderId,
    required String clientId,
    required String designerId,
  }) async {
    isLoading.value = true;

    try {
      if (orderId.trim().isEmpty ||
          clientId.trim().isEmpty ||
          designerId.trim().isEmpty) {
        Get.snackbar(
          'خطأ',
          'تعذر إنشاء غرفة الدردشة بسبب بيانات ناقصة (orderId/clientId/designerId)',
        );
        return;
      }

      _currentUserId = Supabase.instance.client.auth.currentUser!.id;

      final bool isClient = _currentUserId == clientId;

      chatRoom.value = await getChatRoomByOrderId(orderId);

      if (chatRoom.value == null) {
        chatRoom.value = await createChatRoom(
          orderId: orderId,
          clientId: clientId,
          designerId: designerId,
        );
      }

      _subscribeToMessages();

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
    if (chatRoom.value == null) return;
    if (chatRoom.value?.canSendMessage() == false) return;

    final inserted = await sendMessage(
      chatRoomId: chatRoom.value!.id,
      content: text.trim(),
    );

    final existingIndex = messages.indexWhere((m) => m.id == inserted.id);
    if (existingIndex == -1) {
      messages.insert(0, inserted);
    }
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

  void uploadFile() async {
    isLoading.value = true;
    final picker = ImagePicker();

    try {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image == null) {
        isLoading.value = false;
        return;
      }

      final result = await uploadFileUseCase(image);

      result.fold(
        (failure) {
          DialogHelper.showErrorSnackBar(
            title: "خطأ!!",
            message: failure.message,
          );
        },
        (avatarUrl) {
          // ✅ تحديث القيمة بشكل صحيح لتفعيل الـ Obx

          DialogHelper.showSuccessSnackBar(
            title: "نجاح!!",
            message: "تم الرفع بنجاح!",
          );
          log("-------------------------> new avatarUrl : $avatarUrl");
        },
      );
    } catch (e) {
      DialogHelper.showErrorSnackBar(
        title: "خطأ!!",
        message: "حدث خطأ أثناء اختيار الصورة: $e",
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    _messagesSub?.cancel();
    super.onClose();
  }
}
