// lib/screens/resource/resource_screen.dart

import 'package:flutter/material.dart';
import 'asthma_action_plan.dart';
import 'education_materials.dart';
import 'inhaler_guides.dart';

class ResourceScreen extends StatelessWidget {
  const ResourceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Resources"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: const Text("Asthma Action Plan"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AsthmaActionPlanScreen()),
              );
            },
          ),

          ListTile(
            title: const Text("Education Materials"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EducationMaterialsScreen()),
              );
            },
          ),
          ListTile(
            title: const Text("Inhaler Guides"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InhalerGuidesScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
