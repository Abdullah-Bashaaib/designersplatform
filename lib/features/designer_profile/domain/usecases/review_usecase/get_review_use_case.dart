import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/error/failures.dart';

import '../../entities/review.dart';
import '../../repositories/review_repository.dart';

class GetReviewUseCase {
  final ReviewRepository reviewRepository;
  GetReviewUseCase({required this.reviewRepository});

  Future<Either<Failure, Review>> call(int designerId) async {
    return await reviewRepository.getReview(designerId);
  }
}
