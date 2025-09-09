import 'package:dartz/dartz.dart';
import 'package:designers_platform/features/designer_profile/data/models/reivew_model.dart';

abstract class ReviewLocalDataSource {
  Future<ReviewModel> getData(String designerId);
  Future<Unit> addReview(ReviewModel review);
  Future<Unit> updateReview(ReviewModel review);
  Future<Unit> deleteReview(String id);
}
