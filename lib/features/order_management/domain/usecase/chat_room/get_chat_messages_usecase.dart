import '../../entity/chat_room.dart';
import '../../repo/i_chat_repository.dart';

class GetChatMessagesUseCase {
  final IChatRepository repository;
  GetChatMessagesUseCase(this.repository);

  // الـ UseCase فقط "يمرر" استدعاء الـ Stream
  Stream<List<Message>> call(String chatId) {
    return repository.getChatMessages(chatId);
  }
}
