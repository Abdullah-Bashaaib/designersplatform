import 'package:equatable/equatable.dart';

// -------------------------------------------------------------------
// 1. The Message Entity
// -------------------------------------------------------------------
// هذا يمثل "الرسالة" الواحدة.
// This represents a single message bubble.
// -------------------------------------------------------------------

enum MessageType {
  text,
  system, // رسالة من النظام (مثل "تم قبول الطلب")
}

class Message extends Equatable {
  final String id; // ID الرسالة
  final String chatId; // ID الغرفة التي تنتمي لها
  final String senderId; // ID المُرسل
  final String content; // محتوى الرسالة (نص أو رابط للملف)
  final DateTime timestamp;
  final MessageType type;
  final List<String> readBy; // قائمة بـ IDs المستخدمين الذين قرأوها

  const Message({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.content,
    required this.timestamp,
    required this.type,
    this.readBy = const [],
  });

  @override
  List<Object?> get props =>
      [id, chatId, senderId, content, timestamp, type, readBy];
}

// -------------------------------------------------------------------
// 2. The Chat Participant (Value Object)
// -------------------------------------------------------------------
// هذا "كائن قيمة" (Value Object) نظيف لوصف المشاركين.
// نستخدمه لتخزين نسخة من بيانات المستخدم داخل الـ Chat entity
// هذا يمنعنا من عمل fetch لبروفايل المستخدم في كل مرة نعرض قائمة الشات (Denormalization)
// -------------------------------------------------------------------

class Participant extends Equatable {
  final String userId;
  final String displayName;
  final String avatarUrl;

  const Participant({
    required this.userId,
    required this.displayName,
    required this.avatarUrl,
  });

  @override
  List<Object?> get props => [userId, displayName, avatarUrl];
}

// -------------------------------------------------------------------
// 3. The Chat (or ChatRoom) Entity
// -------------------------------------------------------------------
// هذه هي الـ Entity "الرئيسية" التي سألت عنها.
// هي "حاوية" المحادثة.
// -------------------------------------------------------------------

class Chat extends Equatable {
  final String id; // ID الغرفة (يمكن أن يكون هو نفسه orderId)

  // --- الروابط الأساسية (Core Relationships) ---
  final String orderId; // <-- أهم حقل لربطها بـ Order Entity
  final List<Participant>
      participants; // قائمة المشاركين (عادة 2: العميل والمصمم)

  // --- بيانات مُحسّنة للأداء (Denormalized Data) ---
  // نحتاجها لعرض "قائمة المحادثات" بسرعة
  // بدون الحاجة لـ fetch الرسائل أو الـ Order
  final String orderTitle; // نسخة من عنوان الطلب
  final String lastMessageContent; // نسخة من نص آخر رسالة
  final DateTime lastMessageTimestamp; // تاريخ آخر رسالة (لترتيب القائمة)
  final String lastMessageSenderId; // ID مُرسل آخر رسالة

  // --- بيانات الحالة (State Data) ---
  // هذا Map لتتبع عدد الرسائل غير المقروءة لكل مستخدم
  // 'userId1': 3
  // 'userId2': 0
  final Map<String, int> unreadCount;

  const Chat({
    required this.id,
    required this.orderId,
    required this.participants,
    required this.orderTitle,
    this.lastMessageContent = "...",
    required this.lastMessageTimestamp,
    this.lastMessageSenderId = "",
    this.unreadCount = const {},
  });

  @override
  List<Object?> get props => [
        id,
        orderId,
        participants,
        orderTitle,
        lastMessageContent,
        lastMessageTimestamp,
        lastMessageSenderId,
        unreadCount,
      ];
}
