import '../../repo/i_chat_repository.dart';

class CloseChatRoomUseCase {
  final ChatRepository repository;

  CloseChatRoomUseCase(this.repository);

  Future<void> call(String chatRoomId) async {
    return await repository.closeChatRoom(chatRoomId);
  }
}
