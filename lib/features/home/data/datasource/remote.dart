import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:designers_platform/core/error/exception.dart';
import 'package:designers_platform/features/designer_profile/data/models/designer_model.dart';
import 'package:designers_platform/features/designer_profile/domain/entities/designer.dart';

abstract class Remote {
  Future<List<Designer>> getDesigners();
}

class RemoteImp implements Remote {
  final FirebaseFirestore firestore;

  RemoteImp(this.firestore);

  @override
  Future<List<Designer>> getDesigners() async {
    try {
      final data = await firestore
          .collection('Users')
          .where('role', isEqualTo: 'مصمم')
          .get();
      return data.docs.map((d) => DesignerModel.fromJson(d.data())).toList();
    } catch (e) {
      throw ServerException(e);
    }
  }
}
