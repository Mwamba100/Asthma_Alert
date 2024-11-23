import 'package:flutter/material.dart';

class InhalerGuidesScreen extends StatelessWidget {
  const InhalerGuidesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inhaler Guides'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Introduction
            const Text(
              'Inhaler Guides',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Learn how to use different types of inhalers effectively to manage your asthma.',
              style: TextStyle(fontSize: 16),
            ),
            const Divider(height: 30),

            // Inhaler Types
            const SectionHeader(title: 'Types of Inhalers'),
            const ListTile(
              title: Text('Metered-Dose Inhalers (MDIs)'),
              subtitle: Text('Pressurized inhalers that deliver medication in aerosol form.'),
            ),
            const ListTile(
              title: Text('Dry Powder Inhalers (DPIs)'),
              subtitle: Text('Inhalers delivering medication as a dry powder.'),
            ),
            const Divider(height: 30),

            // Step-by-Step Instructions
            const SectionHeader(title: 'Usage Instructions'),
            ListTile(
              title: const Text('How to Use MDIs'),
              subtitle: const Text('Step-by-step guide for Metered-Dose Inhalers.'),
              onTap: () {
                // Navigate to detailed instructions for MDIs
              },
            ),
            const Divider(height: 30),

            // Maintenance and Cleaning
            const SectionHeader(title: 'Maintenance and Cleaning'),
            const ListTile(
              title: Text('Cleaning Tips'),
              subtitle: Text('Keep your inhaler clean and free from clogging.'),
            ),
            const ListTile(
              title: Text('Storage Guidelines'),
              subtitle: Text('Store inhalers in a cool, dry place.'),
            ),
            const Divider(height: 30),

            // Common Mistakes
            const SectionHeader(title: 'Common Mistakes and Troubleshooting'),
            const ListTile(
              title: Text('Avoid These Mistakes'),
              subtitle: Text('Common errors and how to prevent them.'),
            ),
            const ListTile(
              title: Text('Troubleshooting Tips'),
              subtitle: Text('Fix common inhaler problems.'),
            ),
            const Divider(height: 30),

            // Emergency Use
            const SectionHeader(title: 'Emergency Use'),
            const ListTile(
              title: Text('Using an Inhaler in an Emergency'),
              subtitle: Text('Instructions for emergency relief.'),
            ),
          ],
        ),
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  const SectionHeader({required this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
