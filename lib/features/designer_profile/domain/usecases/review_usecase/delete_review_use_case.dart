import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/error/failures.dart';
import 'package:designers_platform/features/designer_profile/domain/repositories/review_repository.dart';

class DeleteReviewUseCase {
  final ReviewRepository reviewRepository;

  DeleteReviewUseCase({required this.reviewRepository});

  Future<Either<Failure, Unit>> call(int id) async {
    return await reviewRepository.deleteReview(id);
  }
}
