import '../../repo/i_chat_repository.dart';

class SendMessageUseCase {
  final ChatRepository repository;

  SendMessageUseCase(this.repository);

  Future<void> call({
    required String chatRoomId,
    required String content,
  }) {
    return repository.sendMessage(
      chatRoomId: chatRoomId,
      content: content,
    );
  }
}
