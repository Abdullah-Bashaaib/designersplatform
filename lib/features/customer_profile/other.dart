import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:designers_platform/features/designer_profile/data/models/designer_model.dart';
import 'package:designers_platform/features/designer_profile/domain/entities/designer.dart';

class Other {
  List<Designer> designerList = [];

  Future<void> getDesigners() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final data = await firestore
        .collection('Users')
        .where('role', isEqualTo: 'مصمم')
        .get();
    designerList =
        data.docs.map((d) => DesignerModel.fromJson(d.data())).toList();
  }
}
