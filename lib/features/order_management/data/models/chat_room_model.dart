import 'package:designers_platform/features/order_management/domain/entity/chat_room.dart';

// ... (imports)

class MessageModel extends Message {
  const MessageModel({
    required super.id,
    required super.chatId,
    required super.senderId,
    required super.content,
    required super.timestamp,
    required super.type,
    required super.readBy,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'chat_id':
          chatId, // Supabase usually uses snake_case, but I should stick to map key conventions if I can't confirm. However, in `ChatRemoteDataSource` I saw `.eq('chat_id', chatId)`. So the database column is `chat_id`. The existing `toJson` used `chatId`. If the DB expects `chat_id`, I should change it. Let's assume snake_case for Supabase columns.
      'sender_id': senderId,
      'content': content,
      'timestamp': timestamp.toIso8601String(),
      'type': type.name,
      'read_by': readBy,
    };
  }

  factory MessageModel.fromJson(Map<String, dynamic> map) {
    return MessageModel(
      id: map['id']?.toString() ?? '',
      chatId: map['chat_id']?.toString() ??
          map['chatId']?.toString() ??
          '', // Safe fallback
      senderId:
          map['sender_id']?.toString() ?? map['senderId']?.toString() ?? '',
      content: map['content']?.toString() ?? '',
      timestamp: map['timestamp'] != null
          ? DateTime.parse(map['timestamp'])
          : DateTime.now(),
      type: MessageType.values.firstWhere(
        (e) => e.name == map['type'],
        orElse: () => MessageType.text,
      ),
      readBy: List<String>.from(map['read_by'] ?? map['readBy'] ?? []),
    );
  }
}
