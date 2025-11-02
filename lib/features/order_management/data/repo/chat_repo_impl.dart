import 'package:designers_platform/features/order_management/data/models/chat_room_model.dart';

import '../../domain/entity/chat_room.dart';
import '../../domain/repo/i_chat_repository.dart';
import '../datasource/chat_remote_datasource.dart';
// (قد تحتاج NetworkInfo هنا لفحص الاتصال قبل الإرسال)

class ChatRepositoryImpl implements IChatRepository {
  final IChatRemoteDataSource remoteDataSource;
  // final INetworkInfo networkInfo;

  ChatRepositoryImpl(this.remoteDataSource);

  @override
  Stream<List<Message>> getChatMessages(String chatId) {
    // ببساطة نمرر الطلب للـ datasource
    return remoteDataSource.getChatMessages(chatId);
  }

  @override
  Future<void> sendMessage(MessageModel message) async {
    // (يمكن إضافة فحص الاتصال هنا)
    return await remoteDataSource.sendMessage(message);
  }
}
