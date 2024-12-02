import 'package:flutter/material.dart';
import '../modules/smoke_detector.dart';

class SmokeLevelScreen extends StatefulWidget {
  final SmokeDetector smokeDetector;

  const SmokeLevelScreen({Key? key, required this.smokeDetector}) : super(key: key);

  @override
  _SmokeLevelScreenState createState() => _SmokeLevelScreenState();
}

class _SmokeLevelScreenState extends State<SmokeLevelScreen> {
  double _currentSmokeLevel = 0.0;
  bool _isAlertActive = false;

  @override
  void initState() {
    super.initState();
    _startSmokeMonitoring();
  }

  void _startSmokeMonitoring() {
    // Simulate a smoke detection process for now
    // You may replace this with real smoke detection code when available
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _currentSmokeLevel = widget.smokeDetector.getCurrentSmokeLevel(); // Replace with actual method to fetch smoke level if available
        _isAlertActive = _currentSmokeLevel > 0.5; // Set threshold for demonstration
      });
    });
  }

  void _resetAlert() {
    setState(() {
      _isAlertActive = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smoke Level Monitoring'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Current Smoke Level: ${_currentSmokeLevel.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            LinearProgressIndicator(
              value: _currentSmokeLevel,
              minHeight: 20,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(
                  _currentSmokeLevel > 0.5 ? Colors.red : Colors.green),
            ),
            const SizedBox(height: 20),
            _isAlertActive
                ? Column(
              children: [
                const Text(
                  'Warning! High Smoke Level Detected!',
                  style: TextStyle(color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _resetAlert,
                  child: const Text('Acknowledge Alert'),
                ),
              ],
            )
                : const Text(
              'Smoke levels are safe.',
              style: TextStyle(color: Colors.green, fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _startSmokeMonitoring,
              child: const Text('Refresh Smoke Level'),
            ),
          ],
        ),
      ),
    );
  }
}
