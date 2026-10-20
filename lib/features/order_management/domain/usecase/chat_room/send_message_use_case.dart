import '../../entity/chat_room.dart';
import '../../repo/i_chat_repository.dart';

class SendMessageUseCase {
  final ChatRepository repository;

  SendMessageUseCase(this.repository);

  Future<ChatMessage> call({
    required String chatRoomId,
    required String content,
  }) async {
    return await repository.sendMessage(
      chatRoomId: chatRoomId,
      content: content,
    );
  }
}
