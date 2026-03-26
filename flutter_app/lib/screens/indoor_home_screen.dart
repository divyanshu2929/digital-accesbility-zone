import 'package:flutter/material.dart';
import 'saved_buildings_screen.dart';
import 'indoor_setup_screen.dart';
import 'indoor_visualization_screen.dart';
import 'visualization_building_screen.dart';

class IndoorHomeScreen extends StatelessWidget {

  const IndoorHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Indoor Mapping"),
      ),

      body: Padding(

        padding: const EdgeInsets.all(20),

        child: Column(

            children: [

              /// Saved Buildings

              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),

                child: ListTile(

                  leading: const Icon(Icons.save, size: 40),

                  title: const Text(
                    "Saved Buildings",
                    style: TextStyle(fontSize: 18),
                  ),

                  subtitle: const Text(
                    "Open previously tested buildings",
                  ),

                  onTap: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SavedBuildingsScreen(),
                      ),
                    );

                  },

                ),
              ),

              const SizedBox(height: 20),

              /// Add Building

              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),

                child: ListTile(

                  leading: const Icon(Icons.add_business, size: 40),

                  title: const Text(
                    "Add Building",
                    style: TextStyle(fontSize: 18),
                  ),

                  subtitle: const Text(
                    "Create a new indoor grid",
                  ),

                  onTap: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const IndoorSetupScreen(),
                      ),
                    );

                  },

                ),
              ),

              const SizedBox(height: 20),

              /// Visualization Button

              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),

                child: ListTile(

                  leading: const Icon(Icons.analytics, size: 40),

                  title: const Text(
                    "Visualization",
                    style: TextStyle(fontSize: 18),
                  ),

                  subtitle: const Text(
                    "View accessibility heatmap",
                  ),

                  onTap: () {

                    /// Temporary example building
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const VisualizationBuildingScreen(),
                      ),
                    );

                  },

                ),
              ),

            ],

        ),

      ),

    );

  }

}