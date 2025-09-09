import 'package:dartz/dartz.dart';
import 'package:designers_platform/features/designer_profile/domain/entities/designer.dart';

abstract class DesignerLocalDataSource {
  Future<Designer> getData();
  Future<Unit> updateData(Designer designer);
  Future<Unit> deleteData();
}
