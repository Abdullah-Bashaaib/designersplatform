import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:designers_platform/features/designer_profile/data/models/designer_model.dart';

abstract class DesignerRemoteDataSource {
  Future<List<DesignerModel>> getAllDesigners();
  Future<DesignerModel?> getData(String id);
  Future<Unit> updateData(DesignerModel designer);
  Future<Unit> deleteData(String id);
}

class DesignerRemoteDataSourceImpByFirebase
    implements DesignerRemoteDataSource {
  final FirebaseFirestore firestore;

  DesignerRemoteDataSourceImpByFirebase({required this.firestore});

  CollectionReference get _designerRef => firestore.collection('designers');

  @override
  Future<List<DesignerModel>> getAllDesigners() async {
    try {
      final querySnapshot = await _designerRef.get();
      final designers = querySnapshot.docs
          .map((doc) => DesignerModel.fromJson(
                doc.data() as Map<String, dynamic>,
              ))
          .toList();
      return designers;
    } catch (e) {
      log("🔥 Error in getAllDesigners: $e");
      return [];
    }
  }

  @override
  Future<DesignerModel?> getData(String id) async {
    try {
      final doc = await _designerRef.doc(id).get();
      if (!doc.exists) return null;
      return DesignerModel.fromJson(doc.data() as Map<String, dynamic>);
    } catch (e) {
      log("🔥 Error in getData: $e");
      return null;
    }
  }

  @override
  Future<Unit> updateData(DesignerModel designer) async {
    try {
      await _designerRef.doc(designer.user.id).set(
            designer.toJson(),
            SetOptions(merge: true),
          );
      return unit;
    } catch (e) {
      print("🔥 Error in updateData: $e");
      return unit;
    }
  }

  @override
  Future<Unit> deleteData(String id) async {
    try {
      await _designerRef.doc(id).delete();
      return unit;
    } catch (e) {
      print("🔥 Error in deleteData: $e");
      return unit;
    }
  }
}
