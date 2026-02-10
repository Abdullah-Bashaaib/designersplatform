import '../../entity/chat_room.dart';
import '../../repo/i_chat_repository.dart';

class SubscribeToMessagesUseCase {
  final ChatRepository repository;

  SubscribeToMessagesUseCase(this.repository);

  Stream<List<ChatMessage>> call(String chatRoomId) {
    return repository.subscribeToMessages(chatRoomId);
  }
}
