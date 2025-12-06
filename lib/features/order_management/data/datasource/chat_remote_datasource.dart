import 'package:designers_platform/core/utils/custom_dialog_getx.dart';
import 'package:designers_platform/features/order_management/data/models/chat_room_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entity/chat_room.dart';

abstract class IChatRemoteDataSource {
  Stream<List<Message>> getChatMessages(String chatId);
  Future<void> sendMessage(MessageModel message);
}

class ChatRemoteDataSourceImpl implements IChatRemoteDataSource {
  final SupabaseClient supabase;

  ChatRemoteDataSourceImpl(this.supabase);

  @override
  Stream<List<Message>> getChatMessages(String chatId) {
    return supabase
        .from('messages')
        .stream(primaryKey: ['id'])
        .eq('chat_id', chatId)
        .order('timestamp')
        .map((maps) => maps.map((m) => MessageModel.fromJson(m)).toList());
  }

  @override
  Future<void> sendMessage(MessageModel message) async {
    try {
      await supabase.from('messages').insert(message.toJson());
    } catch (e) {
      DialogHelper.showErrorSnackBar(
          title: "خطأ", message: "message: ${e.toString()}");
    }
  }
}
