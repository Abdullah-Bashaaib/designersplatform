import '../../domain/entity/chat_room.dart';

class ChatRoomModel extends ChatRoom {
  ChatRoomModel({
    required super.id,
    required super.orderId,
    required super.clientId,
    required super.designerId,
    required super.isClosed,
    required super.createdAt,
    super.closedAt,
    super.lastReadAtByClient,
    super.lastReadAtByDesigner,
  });

  factory ChatRoomModel.fromJson(Map<String, dynamic> json) => ChatRoomModel(
        id: json['id'],
        orderId: json['order_id'],
        clientId: json['client_id'],
        designerId: json['designer_id'],
        isClosed: json['is_closed'],
        createdAt: DateTime.parse(json['created_at']),
        closedAt: json['closed_at'] != null
            ? DateTime.parse(json['closed_at'])
            : null,
        lastReadAtByClient: json['last_read_at_by_client'] != null
            ? DateTime.parse(json['last_read_at_by_client'])
            : null,
        lastReadAtByDesigner: json['last_read_at_by_designer'] != null
            ? DateTime.parse(json['last_read_at_by_designer'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'order_id': orderId,
        'client_id': clientId,
        'designer_id': designerId,
        'is_closed': isClosed,
        'created_at': createdAt.toIso8601String(),
        'closed_at': closedAt?.toIso8601String(),
        'last_read_at_by_client': lastReadAtByClient?.toIso8601String(),
        'last_read_at_by_designer': lastReadAtByDesigner?.toIso8601String(),
      };
}

class ChatMessageModel extends ChatMessage {
  ChatMessageModel(
      {required super.id,
      required super.chatRoomId,
      required super.senderId,
      required super.content,
      required super.createdAt});

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) =>
      ChatMessageModel(
        id: json["id"],
        chatRoomId: json["chat_room_id"],
        senderId: json["sender_id"],
        content: json["content"],
        createdAt: DateTime.parse(json["created_at"]),
      );
}
