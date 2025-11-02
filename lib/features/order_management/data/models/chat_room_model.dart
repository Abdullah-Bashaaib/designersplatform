import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:designers_platform/features/order_management/domain/entity/chat_room.dart';

class MessageModel extends Message {
  const MessageModel({
    required super.id,
    required super.chatId,
    required super.senderId,
    required super.content,
    required super.timestamp,
    required super.type,
    required List<String> readBy,
  });
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'chatId': chatId,
      'senderId': senderId,
      'content': content,
      'timestamp': timestamp,
      'type': type
    };
  }

  factory MessageModel.fromJson(Map<String, dynamic> map) {
    return MessageModel(
      id: map['id'] as String,
      chatId: map['chatId'] as String,
      senderId: map['senderId'] as String,
      content: map['content'] as String,
      // تحويل Timestamp الخاص بـ Firebase إلى DateTime
      timestamp: (map['timestamp'] as Timestamp).toDate(),
      type: MessageType.values.firstWhere(
        (e) => e.name == map['type'],
        orElse: () => MessageType.text,
      ),
      readBy: List<String>.from(map['readBy'] ?? []),
    );
  }
}
