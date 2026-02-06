import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/domain/i_internet_info.dart';
import 'package:designers_platform/core/error/exception.dart';
import 'package:designers_platform/core/error/failures.dart';
import 'package:designers_platform/features/order_management/data/models/chat_room_model.dart';

import '../../domain/entity/chat_room.dart';
import '../../domain/repo/i_chat_repository.dart';
import '../datasource/chat_remote_datasource.dart';
// (قد تحتاج NetworkInfo هنا لفحص الاتصال قبل الإرسال)

class ChatRepositoryImpl implements IChatRepository {
  final IChatRemoteDataSource remoteDataSource;
  final INetworkInfo networkInfo;

  ChatRepositoryImpl(this.remoteDataSource, this.networkInfo);

  @override
  Stream<List<Message>> getChatMessages(String chatId) {
    // ببساطة نمرر الطلب للـ datasource
    return remoteDataSource.getChatMessages(chatId);
  }

  @override
  Future<Either<Failure, Unit>> sendMessage(MessageModel message) async {
    // (يمكن إضافة فحص الاتصال هنا)
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.sendMessage(message);
        return right(unit);
      } on ServerException catch (e) {
        return left(ServerFailure(e.message));
      }
    } else {
      return left(OfflineFailure());
    }
  }
}
