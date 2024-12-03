import 'package:flutter/material.dart';
import 'package:asthma_alert/modules/smoke_detector.dart'; // Make sure this import is correct

class SmokeLevelScreen extends StatelessWidget {
  final SmokeDetector smokeDetector;
  final int smokeLevel; // Declare smokeLevel
  final int threshold; // Declare threshold

  const SmokeLevelScreen({
    Key? key,
    required this.smokeDetector,
    required this.smokeLevel,
    required this.threshold, // Add this line
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smoke Monitoring'),
      ),
      body: Center(
        child: Text('Smoke Level Data: ${smokeDetector.getSmokeLevel()}'),
      ),
    );
  }
}