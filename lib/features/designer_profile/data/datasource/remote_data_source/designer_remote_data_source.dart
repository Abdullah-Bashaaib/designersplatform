import 'package:designers_platform/features/designer_profile/data/models/designer_model.dart';

abstract class DesignerRemoteDataSource {
  Future<DesignerModel> getDesigner(String id);
}
