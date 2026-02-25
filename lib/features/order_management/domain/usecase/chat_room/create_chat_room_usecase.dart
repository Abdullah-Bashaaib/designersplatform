import '../../entity/chat_room.dart';
import '../../repo/i_chat_repository.dart';

class CreateChatRoomUseCase {
  final ChatRepository repository;

  CreateChatRoomUseCase(this.repository);

  Future<ChatRoom> call({
    required String orderId,
    required String clientId,
    required String designerId,
  }) async {
    return await repository.createChatRoom(
      orderId: orderId,
      clientId: clientId,
      designerId: designerId,
    );
  }
}
