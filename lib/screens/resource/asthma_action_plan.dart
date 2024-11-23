import 'package:flutter/material.dart';

class AsthmaActionPlanScreen extends StatelessWidget {
  const AsthmaActionPlanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Asthma Action Plan'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Introduction
            const Text(
              'Your Asthma Action Plan',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Follow this action plan to manage your asthma symptoms effectively. Consult your healthcare provider if you need help updating this plan.',
              style: TextStyle(fontSize: 16),
            ),
            const Divider(height: 30),

            // Zones Section
            ActionZoneCard(
              title: 'Green Zone: Good Control',
              description: 'Your asthma is under control. Continue taking your daily medications.',
              color: Colors.green,
              actionSteps: [
                'Take your daily control medication as prescribed.',
                'Avoid known triggers.',
              ],
            ),
            ActionZoneCard(
              title: 'Yellow Zone: Caution',
              description: 'You are experiencing mild symptoms. Take your quick-relief medication.',
              color: Colors.yellow,
              actionSteps: [
                'Use your rescue inhaler as advised.',
                'Check your peak flow if you feel symptoms worsening.',
              ],
            ),
            ActionZoneCard(
              title: 'Red Zone: Emergency',
              description: 'Severe symptoms are present. Seek medical help immediately.',
              color: Colors.red,
              actionSteps: [
                'Take your emergency medication.',
                'Call your emergency contact or local emergency number.',
              ],
            ),
            const Divider(height: 30),

            // Medication Section
            const Text(
              'Medications',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text('Long-term Control Medication: Take as prescribed'),
            const Text('Quick-Relief Medication: Use as needed during symptoms'),
            const Divider(height: 30),

            // Emergency Contacts
            const Text(
              'Emergency Contacts',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text('Healthcare Provider: Dr. Smith - Phone: (123) 456-7890'),
            const Text('Family Contact: Jane Doe - Phone: (098) 765-4321'),
            const Divider(height: 30),

            // Additional educational resources or tips
            const Text(
              'Asthma Tips and Resources',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text('Review your inhaler technique. Consult with your provider on proper usage.'),
          ],
        ),
      ),
    );
  }
}

class ActionZoneCard extends StatelessWidget {
  final String title;
  final String description;
  final Color color;
  final List<String> actionSteps;

  const ActionZoneCard({
    Key? key,
    required this.title,
    required this.description,
    required this.color,
    required this.actionSteps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color.withOpacity(0.2),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(description, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            ...actionSteps.map((step) => Text('- $step')).toList(),
          ],
        ),
      ),
    );
  }
}
