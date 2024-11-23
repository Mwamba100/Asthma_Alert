// lib/services/firestore_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/health_data.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Add Health Data
  Future<void> addHealthData(HealthData data) async {
    await _db.collection('health_data').add(data.toMap());
  }

  // Add Smoke Level Data
  Future<void> addSmokeLevel(String userId, double smokeLevel) async {
    await _db.collection('smoke_levels').add({
      'userId': userId,
      'smokeLevel': smokeLevel,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  // Get Health Data for a user
  Stream<List<HealthData>> getHealthData(String userId) {
    return _db
        .collection('health_data')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => HealthData.fromMap(doc.data()))
        .toList());
  }

  // Update Settings (example)
  Future<void> updateSettings(String userId, Map<String, dynamic> settings) async {
    await _db.collection('users').doc(userId).update(settings);
  }

  // Get Settings for a user
  Stream<DocumentSnapshot<Map<String, dynamic>>> getSettings(String userId) {
    return _db.collection('users').doc(userId).snapshots();
  }

  // Get Smoke Level Data
  Stream<QuerySnapshot<Map<String, dynamic>>> getSmokeLevels(String userId) {
    return _db
        .collection('smoke_levels')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
