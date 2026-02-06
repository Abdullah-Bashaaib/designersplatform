import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/error/failures.dart';
import 'package:designers_platform/features/order_management/data/models/chat_room_model.dart';

import '../entity/chat_room.dart';

abstract class IChatRepository {
  /// يجلب "Stream" حي ومباشر للرسائل
  Stream<List<Message>> getChatMessages(String chatId);

  /// يرسل رسالة جديدة
  Future<Either<Failure, Unit>> sendMessage(MessageModel message);
}
