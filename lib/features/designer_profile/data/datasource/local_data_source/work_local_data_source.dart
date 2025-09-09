import 'package:dartz/dartz.dart';

import '../../models/work_model.dart';

abstract class WorkLocalDataSource {
  Future<WorkModel> getData();
  Future<Unit> addReview(WorkModel workModel);
  Future<Unit> updateReview(WorkModel workModel);
  Future<Unit> deleteReview(String id);
}
