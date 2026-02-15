import '../../repo/i_chat_repository.dart';

class UpdateLastReadUseCase {
  final ChatRepository repository;

  UpdateLastReadUseCase(this.repository);

  Future<void> call({
    required String chatRoomId,
    required bool isClient,
  }) {
    return repository.updateLastRead(
      chatRoomId: chatRoomId,
      isClient: isClient,
    );
  }
}
