import '../../entity/chat_room.dart';
import '../../repo/i_chat_repository.dart';

class SendMessageUseCase {
  final IChatRepository repository;
  SendMessageUseCase(this.repository);

  // الـ UseCase فقط "يمرر" استدعاء الـ Stream
  Stream<List<Message>> call(String chatId) {
    return repository.getChatMessages(chatId);
  }
}
