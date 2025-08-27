// ignore_for_file: depend_on_referenced_packages

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class FirebaseService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseStorage _storage = FirebaseStorage.instance;

  // Collections
  static const String itemsCollection = 'items';
  static const String usersCollection = 'users';
  static const String ordersCollection = 'orders';

  // Get current user
  static User? get currentUser => _auth.currentUser;

  // Authentication methods
  static Future<UserCredential?> signInWithEmailPassword(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print('Sign in error: $e');
      return null;
    }
  }

  static Future<UserCredential?> registerWithEmailPassword(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print('Registration error: $e');
      return null;
    }
  }

  static Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print('Sign out error: $e');
    }
  }

  // Firestore operations
  static Future<DocumentSnapshot?> getDocument(String collection, String docId) async {
    try {
      return await _firestore.collection(collection).doc(docId).get();
    } catch (e) {
      print('Get document error: $e');
      return null;
    }
  }

  static Future<QuerySnapshot?> getCollection(String collection, {
    int? limit,
    String? orderBy,
    bool descending = false,
    Map<String, dynamic>? where,
  }) async {
    try {
      Query query = _firestore.collection(collection);

      if (where != null) {
        where.forEach((field, value) {
          query = query.where(field, isEqualTo: value);
        });
      }

      if (orderBy != null) {
        query = query.orderBy(orderBy, descending: descending);
      }

      if (limit != null) {
        query = query.limit(limit);
      }

      return await query.get();
    } catch (e) {
      print('Get collection error: $e');
      return null;
    }
  }

  static Future<DocumentReference?> addDocument(String collection, Map<String, dynamic> data) async {
    try {
      data['createdAt'] = FieldValue.serverTimestamp();
      data['updatedAt'] = FieldValue.serverTimestamp();
      return await _firestore.collection(collection).add(data);
    } catch (e) {
      print('Add document error: $e');
      return null;
    }
  }

  static Future<bool> updateDocument(String collection, String docId, Map<String, dynamic> data) async {
    try {
      data['updatedAt'] = FieldValue.serverTimestamp();
      await _firestore.collection(collection).doc(docId).update(data);
      return true;
    } catch (e) {
      print('Update document error: $e');
      return false;
    }
  }

  static Future<bool> deleteDocument(String collection, String docId) async {
    try {
      await _firestore.collection(collection).doc(docId).delete();
      return true;
    } catch (e) {
      print('Delete document error: $e');
      return false;
    }
  }

  // Upload file to Firebase Storage
  static Future<String?> uploadFile(String path, File file) async {
    try {
      final ref = _storage.ref().child(path);
      final uploadTask = await ref.putFile(file);
      return await uploadTask.ref.getDownloadURL();
    } catch (e) {
      print('Upload file error: $e');
      return null;
    }
  }

  // Real-time listeners
  static Stream<QuerySnapshot> getCollectionStream(String collection, {
    int? limit,
    String? orderBy,
    bool descending = false,
    Map<String, dynamic>? where,
  }) {
    Query query = _firestore.collection(collection);

    if (where != null) {
      where.forEach((field, value) {
        query = query.where(field, isEqualTo: value);
      });
    }

    if (orderBy != null) {
      query = query.orderBy(orderBy, descending: descending);
    }

    if (limit != null) {
      query = query.limit(limit);
    }

    return query.snapshots();
  }

  static Stream<DocumentSnapshot> getDocumentStream(String collection, String docId) {
    return _firestore.collection(collection).doc(docId).snapshots();
  }
}