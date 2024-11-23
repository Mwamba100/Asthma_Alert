// lib/models/health_data.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class HealthData {
  String userId;
  double peakFlow;
  int heartRate;
  String symptoms;
  DateTime timestamp;

  HealthData({
    required this.userId,
    required this.peakFlow,
    required this.heartRate,
    required this.symptoms,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'peakFlow': peakFlow,
      'heartRate': heartRate,
      'symptoms': symptoms,
      'timestamp': timestamp,
    };
  }

  factory HealthData.fromMap(Map<String, dynamic> map) {
    return HealthData(
      userId: map['userId'],
      peakFlow: map['peakFlow'],
      heartRate: map['heartRate'],
      symptoms: map['symptoms'],
      timestamp: (map['timestamp'] as Timestamp).toDate(),
    );
  }
}
