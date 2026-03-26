import 'package:flutter/material.dart';
import 'backend_setup_screen.dart';
import 'saved_buildings_screen.dart';
import 'outdoor_map_screen.dart';
import 'indoor_home_screen.dart';

class ModeSelectionScreen extends StatelessWidget {

  const ModeSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Digital Accessibility Zones"),

        actions: [

          IconButton(
            icon: const Icon(Icons.settings),

            onPressed: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const BackendSetupScreen(),
                ),
              );

            },
          )

        ],
      ),

      body: Padding(

        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            /// Indoor Mapping Card

            Card(

              elevation: 8,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),

              child: ListTile(

                contentPadding:
                const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 15),

                leading: const Icon(
                  Icons.apartment,
                  size: 40,
                  color: Colors.blue,
                ),

                title: const Text(
                  "Indoor Mapping",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                subtitle: const Text(
                  "Test building accessibility",
                ),

                onTap: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                      const IndoorHomeScreen(),
                    ),
                  );

                },

              ),

            ),

            const SizedBox(height: 25),

            /// Outdoor Mapping Card

            Card(

              elevation: 8,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),

              child: ListTile(

                contentPadding:
                const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 15),

                leading: const Icon(
                  Icons.public,
                  size: 40,
                  color: Colors.green,
                ),

                title: const Text(
                  "Outdoor Mapping",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                subtitle: const Text(
                  "View outdoor accessibility map",
                ),

                onTap: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                      const OutdoorMapScreen(),
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