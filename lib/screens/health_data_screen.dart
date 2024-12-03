import 'package:flutter/material.dart';

class HealthDataScreen extends StatelessWidget {
  const HealthDataScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Data'),
      ),
      body: Center(
        child: Text('Health Data Screen'),
      ),
    );
  }
}