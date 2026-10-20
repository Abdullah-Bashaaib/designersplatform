import 'dart:developer';

import 'package:designers_platform/core/error/exception.dart';
import 'package:designers_platform/features/order_management/data/models/chat_room_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ChatRemoteDataSource {
  /// إنشاء غرفة شات (عند قبول الطلب)
  Future<ChatRoomModel> createChatRoom({
    required String orderId,
    required String clientId,
    required String designerId,
  });

  /// جلب غرفة الشات حسب الطلب
  Future<ChatRoomModel?> getChatRoomByOrderId(String orderId);

  /// الاستماع للرسائل (Realtime)
  Stream<List<ChatMessageModel>> subscribeToMessages(String chatRoomId);

  /// إرسال رسالة
  Future<ChatMessageModel> sendMessage({
    required String chatRoomId,
    required String content,
  });

  /// تحديث وقت القراءة
  Future<void> updateLastRead({
    required String chatRoomId,
    required bool isClient,
  });

  /// رفع الملف لاكمال الطلب وغلق الشات
  Future<String> uploadFile(XFile image);

  /// إغلاق الشات
  Future<void> closeChatRoom(String chatRoomId);
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final SupabaseClient supabase;

  ChatRemoteDataSourceImpl(this.supabase);

  String get _userId => supabase.auth.currentUser!.id;

  // ------------------------------------------
  // Create chat room
  // ------------------------------------------
  @override
  Future<ChatRoomModel> createChatRoom({
    required String orderId,
    required String clientId,
    required String designerId,
  }) async {
    final response = await supabase
        .from('chat_rooms')
        .insert({
          'order_id': orderId,
          'client_id': clientId,
          'designer_id': designerId,
        })
        .select()
        .single();

    return ChatRoomModel.fromJson(response);
  }

  // ------------------------------------------
  // Get chat room by order id
  // ------------------------------------------
  @override
  Future<ChatRoomModel?> getChatRoomByOrderId(String orderId) async {
    final response = await supabase
        .from('chat_rooms')
        .select()
        .eq('order_id', orderId)
        .maybeSingle();

    if (response == null) return null;
    return ChatRoomModel.fromJson(response);
  }

  // ------------------------------------------
  // Realtime messages stream
  // ------------------------------------------
  @override
  Stream<List<ChatMessageModel>> subscribeToMessages(String chatRoomId) {
    return supabase
        .from('chat_messages')
        .stream(primaryKey: ['id'])
        .eq('chat_room_id', chatRoomId)
        .order('created_at', ascending: false)
        .map(
          (rows) => rows.map(ChatMessageModel.fromJson).toList(),
        );
  }

  // ------------------------------------------
  // Send message
  // ------------------------------------------
  @override
  Future<ChatMessageModel> sendMessage({
    required String chatRoomId,
    required String content,
  }) async {
    final response = await supabase
        .from('chat_messages')
        .insert({
          'chat_room_id': chatRoomId,
          'sender_id': _userId,
          'content': content,
        })
        .select()
        .single();

    return ChatMessageModel.fromJson(response);
  }

  // ------------------------------------------
  // Update last read
  // ------------------------------------------
  @override
  Future<void> updateLastRead({
    required String chatRoomId,
    required bool isClient,
  }) async {
    await supabase.from('chat_rooms').update({
      isClient ? 'last_read_at_by_client' : 'last_read_at_by_designer':
          DateTime.now().toIso8601String(),
    }).eq('id', chatRoomId);
  }

  // ------------------------------------------
  // Close chat room
  // ------------------------------------------
  @override
  Future<void> closeChatRoom(String chatRoomId) async {
    await supabase.from('chat_rooms').update({
      'is_closed': true,
      'closed_at': DateTime.now().toIso8601String(),
    }).eq('id', chatRoomId);
  }

  @override
  Future<String> uploadFile(XFile image) async {
    try {
      // تحقق من وجود المستخدم
      final user = supabase.auth.currentUser;
      if (user == null) {
        log('=====================');
        log('المستخدم غير مسجل الدخول!');
        log('=====================');
        throw Exception('يجب تسجيل الدخول أولاً');
      }

      log('=====================');
      log('المستخدم الحالي: ${user.id}');
      log('البريد الإلكتروني: ${user.email}');
      log('=====================');

      final imageByte = await image.readAsBytes();
      final userId = user.id; // استخدم user.id من Supabase Auth مباشرة
      final uuid = DateTime.now().toIso8601String();
      final imagePath = '$userId/$uuid.png';

      log('محاولة رفع الملف إلى المسار: $imagePath');

      await supabase.storage.from('designsFile').uploadBinary(
            imagePath,
            imageByte,
          );

      final imageUrl =
          supabase.storage.from('designsFile').getPublicUrl(imagePath);
      return imageUrl;
    } catch (e) {
      log('----------------> ${e.toString()}');
      throw ServerException(e);
    }
  }
}
