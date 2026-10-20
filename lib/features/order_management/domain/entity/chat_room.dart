class ChatRoom {
  final String id;
  final String orderId;

  // الأطراف (اثنين فقط)
  final String clientId;
  final String designerId;

  // حالة الشات
  final bool isClosed;

  // التواريخ
  final DateTime createdAt;
  final DateTime? closedAt;

  // القراءة
  final DateTime? lastReadAtByClient;
  final DateTime? lastReadAtByDesigner;

  const ChatRoom({
    required this.id,
    required this.orderId,
    required this.clientId,
    required this.designerId,
    required this.isClosed,
    required this.createdAt,
    this.closedAt,
    this.lastReadAtByClient,
    this.lastReadAtByDesigner,
  });

  /// منطق بسيط داخل الدومين
  bool canSendMessage() => !isClosed;

  ChatRoom copyWith({
    bool? isClosed,
    DateTime? closedAt,
    DateTime? lastReadAtByClient,
    DateTime? lastReadAtByDesigner,
  }) {
    return ChatRoom(
      id: id,
      orderId: orderId,
      clientId: clientId,
      designerId: designerId,
      isClosed: isClosed ?? this.isClosed,
      createdAt: createdAt,
      closedAt: closedAt ?? this.closedAt,
      lastReadAtByClient: lastReadAtByClient ?? this.lastReadAtByClient,
      lastReadAtByDesigner: lastReadAtByDesigner ?? this.lastReadAtByDesigner,
    );
  }
}

class ChatMessage {
  final String id;
  final String chatRoomId;

  // من أرسل الرسالة
  final String senderId;

  // المحتوى (نص فقط)
  final String content;

  // وقت الإرسال (من السيرفر)
  final DateTime createdAt;

  const ChatMessage({
    required this.id,
    required this.chatRoomId,
    required this.senderId,
    required this.content,
    required this.createdAt,
  });
}
