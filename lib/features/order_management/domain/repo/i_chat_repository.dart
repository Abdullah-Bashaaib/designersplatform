import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/error/failures.dart';
import 'package:image_picker/image_picker.dart';

import '../entity/chat_room.dart';

abstract class ChatRepository {
  /// إنشاء غرفة شات عند قبول الطلب
  Future<ChatRoom> createChatRoom({
    required String orderId,
    required String clientId,
    required String designerId,
  });

  /// جلب غرفة الشات المرتبطة بالطلب
  Future<ChatRoom?> getChatRoomByOrderId(String orderId);

  /// الاستماع للرسائل (Realtime)
  Stream<List<ChatMessage>> subscribeToMessages(String chatRoomId);

  /// إرسال رسالة نصية
  Future<ChatMessage> sendMessage({
    required String chatRoomId,
    required String content,
  });

  /// تحديث وقت القراءة
  Future<void> updateLastRead({
    required String chatRoomId,
    required bool isClient,
  });

  Future<Either<Failure, String>> uploadFile(XFile image);

  /// إغلاق الشات عند تسليم الطلب
  Future<void> closeChatRoom(String chatRoomId);
}
