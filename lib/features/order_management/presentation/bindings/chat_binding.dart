import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../data/datasource/chat_remote_datasource.dart';
import '../../data/repo/chat_repo_impl.dart';
import '../../domain/repo/i_chat_repository.dart';
import '../../domain/usecase/chat_room/close_chat_room_use_case.dart';
import '../../domain/usecase/chat_room/create_chat_room_usecase.dart';
import '../../domain/usecase/chat_room/get_chat_room_by_orderId_usecase.dart';
import '../../domain/usecase/chat_room/send_message_use_case.dart';
import '../../domain/usecase/chat_room/subscribe_to_messages_use_case.dart';
import '../../domain/usecase/chat_room/update_last_read_use_case.dart';
import '../getx/chat_getx.dart';

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    final supabase = Supabase.instance.client;

    // DataSource
    Get.lazyPut<ChatRemoteDataSource>(
      () => ChatRemoteDataSourceImpl(supabase),
    );

    // Repository
    Get.lazyPut<ChatRepository>(
      () => ChatRepositoryImpl(Get.find<ChatRemoteDataSource>()),
    );

    // UseCases
    Get.lazyPut<CreateChatRoomUseCase>(() => CreateChatRoomUseCase(Get.find()));
    Get.lazyPut<GetChatRoomByOrderIdUseCase>(() => GetChatRoomByOrderIdUseCase(Get.find()));
    Get.lazyPut<SubscribeToMessagesUseCase>(() => SubscribeToMessagesUseCase(Get.find()));
    Get.lazyPut<SendMessageUseCase>(() => SendMessageUseCase(Get.find()));
    Get.lazyPut<UpdateLastReadUseCase>(() => UpdateLastReadUseCase(Get.find()));
    Get.lazyPut<CloseChatRoomUseCase>(() => CloseChatRoomUseCase(Get.find()));

    // Controller
    Get.lazyPut(
      () => ChatController(
        createChatRoom: Get.find(),
        getChatRoomByOrderId: Get.find(),
        subscribeToMessages: Get.find(),
        sendMessage: Get.find(),
        updateLastRead: Get.find(),
        closeChatRoom: Get.find(),
      ),
    );
  }
}
