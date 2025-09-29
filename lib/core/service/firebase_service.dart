import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db;

  FirestoreService(this._db);

  /// إضافة document جديد
  Future<void> addDocument({
    required String collection,
    required Map<String, dynamic> data,
    String? docId,
  }) async {
    if (docId != null) {
      await _db.collection(collection).doc(docId).set(data);
    } else {
      await _db.collection(collection).add(data);
    }
  }

  /// قراءة document واحد
  Future<DocumentSnapshot<Map<String, dynamic>>> getDocument({
    required String collection,
    required String docId,
  }) async {
    return await _db.collection(collection).doc(docId).get();
  }

  /// قراءة list من documents مع إمكانية إضافة شرط
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getDocuments({
    required String collection,
    String? field,
    dynamic isEqualTo,
  }) async {
    Query<Map<String, dynamic>> query = _db.collection(collection);
    if (field != null && isEqualTo != null) {
      query = query.where(field, isEqualTo: isEqualTo);
    }
    final result = await query.get();
    return result.docs;
  }

  /// تحديث document
  Future<void> updateDocument({
    required String collection,
    required String docId,
    required Map<String, dynamic> data,
  }) async {
    await _db.collection(collection).doc(docId).update(data);
  }

  /// حذف document
  Future<void> deleteDocument({
    required String collection,
    required String docId,
  }) async {
    await _db.collection(collection).doc(docId).delete();
  }
}
