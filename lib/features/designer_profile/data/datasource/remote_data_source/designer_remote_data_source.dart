import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/error/exception.dart';
import 'package:designers_platform/features/designer_profile/data/models/designer_model.dart';

abstract class DesignerRemoteDataSource {
  Future<DesignerModel?> getData(String id);
  Future<Unit> updateData(DesignerModel designer);
  Future<Unit> deleteData(String id);
}

class DesignerRemoteDataSourceImpByFirebase
    implements DesignerRemoteDataSource {
  final FirebaseFirestore firestore;

  DesignerRemoteDataSourceImpByFirebase({required this.firestore});

  CollectionReference get _designerRef => firestore.collection('Users');

  @override
  Future<DesignerModel?> getData(String id) async {
    try {
      final doc = await _designerRef
          .doc(id)
          .get(const GetOptions(source: Source.serverAndCache));
      if (!doc.exists) return null;
      return DesignerModel.fromJson(doc.data() as Map<String, dynamic>);
    } catch (e) {
      log("-------------------------------------> Error in Firebase : $e");
      throw ServerException(e);
    }
  }

  @override
  Future<Unit> updateData(DesignerModel designer) async {
    try {
      await _designerRef.doc(designer.id).set(
            designer.toJson(),
            SetOptions(merge: true),
          );
      return unit;
    } catch (e) {
      throw ServerException(e);
    }
  }

  @override
  Future<Unit> deleteData(String id) async {
    try {
      await _designerRef.doc(id).delete();
      return unit;
    } catch (e) {
      throw ServerException(e);
    }
  }
}
