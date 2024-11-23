// lib/screens/health_data_screen.dart

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../modules/health_data.dart';
import '../services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HealthDataScreen extends StatefulWidget {
  final HealthData healthData;
  const HealthDataScreen({Key? key, required this.healthData}) : super(key: key);

  @override
  _HealthDataScreenState createState() => _HealthDataScreenState();
}

class _HealthDataScreenState extends State<HealthDataScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  late String userId;

  @override
  void initState() {
    super.initState();
    userId = FirebaseAuth.instance.currentUser!.uid;
    // Optionally start data collection here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Data'),
      ),
      body: StreamBuilder<List<HealthData>>(
        stream: _firestoreService.getHealthData(userId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Error loading data.'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final data = snapshot.data!;
          if (data.isEmpty) {
            return const Center(child: Text('No health data available.'));
          }
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final healthData = data[index];
              return ListTile(
                title: Text(
                    'Peak Flow: ${healthData.peakFlow} μg/m³, Heart Rate: ${healthData.heartRate} bpm'),
                subtitle: Text(
                    'Symptoms: ${healthData.symptoms}\nTime: ${healthData.timestamp}'),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addSampleData, // Replace with actual data input
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addSampleData() {
    // Example function to add sample data
    final newData = HealthData(
      userId: userId,
      peakFlow: 400.0,
      heartRate: 80,
      symptoms: 'No symptoms',
      timestamp: DateTime.now(),
    );
    _firestoreService.addHealthData(newData);
  }
}
