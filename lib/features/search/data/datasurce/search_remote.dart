import 'package:designers_platform/features/designer_profile/domain/entities/designer.dart';

abstract class SearchRemote {
  Future<List<Designer>> searchDesigners(String query);
  Future<List<Map<String, dynamic>>> searchDesigns(String query);
}

class SearchRemoteImp implements SearchRemote {
  @override
  Future<List<Designer>> searchDesigners(String query) {
    // TODO: implement searchDesigners
    throw UnimplementedError();
  }

  @override
  Future<List<Map<String, dynamic>>> searchDesigns(String query) {
    // TODO: implement searchDesigns
    throw UnimplementedError();
  }
}
