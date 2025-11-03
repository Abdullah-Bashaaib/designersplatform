import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:designers_platform/core/utils/custom_dialog_getx.dart';
import 'package:designers_platform/features/order_management/data/models/chat_room_model.dart';

import '../../domain/entity/chat_room.dart';

abstract class IChatRemoteDataSource {
  Stream<List<Message>> getChatMessages(String chatId);
  Future<void> sendMessage(MessageModel message);
}

class ChatRemoteDataSourceImpl implements IChatRemoteDataSource {
  final FirebaseFirestore _firestore;

  ChatRemoteDataSourceImpl(this._firestore);

  @override
  Stream<List<Message>> getChatMessages(String chatId) {
    // 1. اذهب إلى collection الرسائل الصحيح
    return _firestore
        .collection('chats') // أو 'orders'
        .doc(chatId) // هذا هو ID الطلب أو الشات
        .collection('messages')
        .orderBy('timestamp') // رتبها حسب الوقت
        .snapshots() // <-- 💡 هذا هو الـ STREAM الحقيقي!
        .map((snapshot) {
      // 2. حول الـ snapshot إلى List<Message>
      return snapshot.docs
          .map(
            (doc) => MessageModel.fromJson(
              doc.data(),
            ),
          )
          .toList();
    });
  }

  @override
  Future<void> sendMessage(MessageModel message) async {
    try {
      await _firestore
          .collection('chats')
          .doc(message.chatId)
          .collection('messages')
          .doc(message.id) // نستخدم ID الرسالة كـ doc ID
          .set(message.toJson());
    } catch (e) {
      DialogHelper.showErrorSnackBar(
          title: "خطأ", message: "message: ${e.toString()}");
    }

    // (هنا أيضاً يجب تحديث lastMessage في الـ Chat entity)
  }
}
