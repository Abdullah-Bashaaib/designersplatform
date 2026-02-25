import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/error/failures.dart';
import 'package:designers_platform/features/order_management/domain/repo/i_chat_repository.dart';
import 'package:image_picker/image_picker.dart';

class UploadFileUseCase {
  final ChatRepository repository;

  UploadFileUseCase(this.repository);

  Future<Either<Failure, String>> call(XFile image) async {
    return await repository.uploadFile(image);
  }
}
