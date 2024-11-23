// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import '../modules/smoke_detector.dart';
import '../modules/health_data.dart';
import 'health_data_screen.dart';
import 'app_drawer.dart';

class HomeScreen extends StatefulWidget {
  final SmokeDetector smokeDetector;
  final HealthData healthData;

  const HomeScreen({
    Key? key,
    required this.smokeDetector,
    required this.healthData,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    widget.smokeDetector.startSmokeLevelSimulation(); // Start simulation
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Asthma Alert App"),
      ),
      drawer: AppDrawer(), // Add the AppDrawer here for navigation
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Current Smoke Level: ${widget.smokeDetector.smokeLevel}",
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Text(
              "Smoke Threshold: ${widget.smokeDetector.smokeThreshold}",
              style: TextStyle(fontSize: 18),
            ),
            Slider(
              min: 0,
              max: 150,
              divisions: 15,
              label: widget.smokeDetector.smokeThreshold.toString(),
              value: widget.smokeDetector.smokeThreshold,
              onChanged: (double value) {
                setState(() {
                  widget.smokeDetector.smokeThreshold = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        HealthDataScreen(healthData: widget.healthData),
                  ),
                );
              },
              child: Text("View Health Data"),
            ),
          ],
        ),
      ),
    );
  }
}
