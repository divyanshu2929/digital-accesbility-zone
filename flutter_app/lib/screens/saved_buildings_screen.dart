import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'indoor_grid_screen.dart';
import 'floor_selection_screen.dart';

class SavedBuildingsScreen extends StatefulWidget {

  const SavedBuildingsScreen({Key? key}) : super(key: key);

  @override
  State<SavedBuildingsScreen> createState() => _SavedBuildingsScreenState();
}

class _SavedBuildingsScreenState extends State<SavedBuildingsScreen> {

  List buildings = [];

  @override
  void initState() {
    super.initState();
    loadBuildings();
  }

  loadBuildings() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      buildings = prefs.getStringList("buildings") ?? [];
    });

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(title: const Text("Saved Buildings")),

      body: ListView.builder(

        itemCount: buildings.length,

        itemBuilder: (_, i) {

          List parts = buildings[i].split("|");

          String name = parts[0];
          int floors = int.parse(parts[1]);
          double length = double.parse(parts[2]);
          double width = double.parse(parts[3]);

          return ListTile(

            title: Text(name),

            subtitle: Text(
                "$floors floors • ${length}m × ${width}m"
            ),

            onTap: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FloorSelectionScreen(
                    name,
                    floors,
                    length,
                    width,
                  ),
                ),
              );

            },

          );
        },

      ),

    );

  }

}