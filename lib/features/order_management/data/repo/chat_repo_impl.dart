import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/error/failures.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/current_user.dart';
import '../../../../core/error/exception.dart';
import '../../domain/entity/chat_room.dart';
import '../../domain/repo/i_chat_repository.dart';
import '../datasource/chat_remote_datasource.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;

  ChatRepositoryImpl(this.remoteDataSource);

  @override
  Future<ChatRoom> createChatRoom({
    required String orderId,
    required String clientId,
    required String designerId,
  }) async {
    return await remoteDataSource.createChatRoom(
      orderId: orderId,
      clientId: clientId,
      designerId: designerId,
    );
  }

  @override
  Future<ChatRoom?> getChatRoomByOrderId(String orderId) async {
    return await remoteDataSource.getChatRoomByOrderId(orderId);
  }

  @override
  Stream<List<ChatMessage>> subscribeToMessages(String chatRoomId) {
    return remoteDataSource.subscribeToMessages(chatRoomId);
  }

  @override
  Future<ChatMessage> sendMessage({
    required String chatRoomId,
    required String content,
  }) async {
    return await remoteDataSource.sendMessage(
      chatRoomId: chatRoomId,
      content: content,
    );
  }

  @override
  Future<void> updateLastRead({
    required String chatRoomId,
    required bool isClient,
  }) async {
    await remoteDataSource.updateLastRead(
      chatRoomId: chatRoomId,
      isClient: isClient,
    );
  }

  @override
  Future<void> closeChatRoom(String chatRoomId) async {
    await remoteDataSource.closeChatRoom(chatRoomId);
  }

  @override
  Future<Either<Failure, String>> uploadFile(XFile image) async {
    try {
      final imageUrl = await remoteDataSource.uploadFile(image);
      CurrentUser.currentUser!.avatarUrl = imageUrl;
      return right(imageUrl);
    } on ServerException catch (e) {
      return left(ServerFailure(e.message.toString()));
    }
  }
}
