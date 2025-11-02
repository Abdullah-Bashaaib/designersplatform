import 'package:designers_platform/features/order_management/data/models/chat_room_model.dart';

import '../entity/chat_room.dart';

abstract class IChatRepository {
  /// يجلب "Stream" حي ومباشر للرسائل
  Stream<List<Message>> getChatMessages(String chatId);

  /// يرسل رسالة جديدة
  Future<void> sendMessage(MessageModel message);
}
