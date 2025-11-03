import 'package:designers_platform/features/order_management/data/models/chat_room_model.dart';

import '../../repo/i_chat_repository.dart';

class SendMessageUseCase {
  final IChatRepository repository;
  SendMessageUseCase(this.repository);

  // الـ UseCase فقط "يمرر" استدعاء الـ Stream
  Future<void> call(MessageModel message) async {
    return await repository.sendMessage(message);
  }
}
