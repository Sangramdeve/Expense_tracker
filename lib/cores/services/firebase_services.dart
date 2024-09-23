import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expance_traker/app_imports.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addDocument({
    required String collectionPath,
    required TransactionData data,
  }) async {
    try {
      await _firestore.collection(collectionPath).add(data.toMap());
    } catch (e) {
      rethrow;
    }
  }

  Future<DocumentSnapshot> getDocument({
    required String collectionPath,
    required String documentId,
  }) async {
    try {
      DocumentSnapshot documentSnapshot =
          await _firestore.collection(collectionPath).doc(documentId).get();
      return documentSnapshot;
    } catch (e) {
      print('firebase error: $e');
      rethrow;
    }
  }

  Future<List<DocumentSnapshot>> getAllDocuments({
    required String classpath,
  }) async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection(classpath).get();
      return querySnapshot.docs;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateDocument({
    required String collectionPath,
    required String documentId,
    required Map<String, dynamic> data,
  }) async {
    try {
      await _firestore.collection(collectionPath).doc(documentId).update(data);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteDocument({
    required String collectionPath,
    required String documentId,
  }) async {
    try {
      await _firestore.collection(collectionPath).doc(documentId).delete();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<DocumentSnapshot>> queryDocuments({
    required String collectionPath,
    required String field,
    required dynamic value,
  }) async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection(collectionPath).where(field).get();

      return querySnapshot.docs;
    } catch (e) {
      rethrow;
    }
  }
}
