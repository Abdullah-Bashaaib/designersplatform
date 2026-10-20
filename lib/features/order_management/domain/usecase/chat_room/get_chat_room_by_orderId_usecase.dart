import '../../entity/chat_room.dart';
import '../../repo/i_chat_repository.dart';

class GetChatRoomByOrderIdUseCase {
  final ChatRepository repository;

  GetChatRoomByOrderIdUseCase(this.repository);

  Future<ChatRoom?> call(String orderId) async {
    return await repository.getChatRoomByOrderId(orderId);
  }
}
