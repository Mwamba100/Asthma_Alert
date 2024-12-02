import 'package:flutter/material.dart';

class CommunitySupportScreen extends StatelessWidget {
  const CommunitySupportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community Support'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header and Introduction
            const Text(
              'Community Support',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Connect with others, find resources, and gain support for managing your asthma journey.',
              style: TextStyle(fontSize: 16),
            ),
            const Divider(height: 30),

            // Online and Local Support Groups
            const SectionHeader(title: 'Support Groups'),
            SupportLink(
              title: 'Asthma UK Forum',
              description: 'Join an active community for advice and support.',
              url: 'https://www.asthma.org.uk/forum',
            ),
            SupportLink(
              title: 'Allergy & Asthma Network',
              description: 'A support network for people with asthma and allergies.',
              url: 'https://www.allergyasthmanetwork.org/',
            ),
            const Divider(height: 30),

            // Educational Articles
            const SectionHeader(title: 'Educational Articles'),
            const ArticleTile(
              title: 'Managing Asthma Triggers',
              description: 'Learn how to identify and avoid asthma triggers.',
            ),
            const ArticleTile(
              title: 'Asthma and Exercise',
              description: 'Tips for staying active with asthma safely.',
            ),
            const Divider(height: 30),

            // Success Stories and Testimonials
            const SectionHeader(title: 'Success Stories'),
            const Text(
              'Read inspiring stories from others managing asthma:',
              style: TextStyle(fontSize: 16),
            ),
            const StoryTile(
              title: 'How I Controlled My Asthma with a Balanced Lifestyle',
              story: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit...',
            ),
            const Divider(height: 30),

            // Caregiver Resources
            const SectionHeader(title: 'Resources for Caregivers'),
            const Text(
              'Helpful tips for family and caregivers to support asthma patients.',
              style: TextStyle(fontSize: 16),
            ),
            const ListTile(
              title: Text('Emergency Preparedness Tips'),
              subtitle: Text('Be ready for asthma emergencies.'),
            ),
            const Divider(height: 30),

            // Events and Workshops
            const SectionHeader(title: 'Events & Workshops'),
            const EventTile(
              title: 'World Asthma Day Workshop',
              description: 'Join us for an online event to learn more about asthma management.',
            ),
            const Divider(height: 30),

            // Interactive Tools
            const SectionHeader(title: 'Interactive Tools'),
            ListTile(
              title: const Text('Asthma Symptom Quiz'),
              subtitle: const Text('Take a quiz to assess your asthma control.'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                // Navigate to quiz or tool screen
              },
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

class SupportLink extends StatelessWidget {
  final String title;
  final String description;
  final String url;

  const SupportLink({required this.title, required this.description, required this.url, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(description),
      trailing: const Icon(Icons.link),
      onTap: () {
        // Implement link navigation
      },
    );
  }
}

class ArticleTile extends StatelessWidget {
  final String title;
  final String description;
  const ArticleTile({required this.title, required this.description, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(description),
      onTap: () {
        // Navigate to article details screen
      },
    );
  }
}

class StoryTile extends StatelessWidget {
  final String title;
  final String story;
  const StoryTile({required this.title, required this.story, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(story, maxLines: 2, overflow: TextOverflow.ellipsis),
      onTap: () {
        // Navigate to full story screen
      },
    );
  }
}

class EventTile extends StatelessWidget {
  final String title;
  final String description;
  const EventTile({required this.title, required this.description, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(description),
      onTap: () {
        // Navigate to event details screen
      },
    );
  }
}
