import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/error/failures.dart';
import 'package:designers_platform/features/designer_profile/domain/entities/review.dart';
import 'package:designers_platform/features/designer_profile/domain/repositories/review_repository.dart';

class UpdateReviewUseCase {
  final ReviewRepository reviewRepository;

  UpdateReviewUseCase({required this.reviewRepository});

  Future<Either<Failure, Unit>> call(Review review) async {
    return await reviewRepository.updateReview(review);
  }
}
