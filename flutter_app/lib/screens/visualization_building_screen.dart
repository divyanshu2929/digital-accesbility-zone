import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'visualization_floor_screen.dart';

class VisualizationBuildingScreen extends StatefulWidget {

  const VisualizationBuildingScreen({Key? key}) : super(key: key);

  @override
  State<VisualizationBuildingScreen> createState() =>
      _VisualizationBuildingScreenState();
}

class _VisualizationBuildingScreenState
    extends State<VisualizationBuildingScreen> {

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

      appBar: AppBar(
        title: const Text("Choose Building"),
      ),

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

            subtitle: Text("$floors floors"),

            trailing: const Icon(Icons.arrow_forward),

            onTap: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => VisualizationFloorScreen(
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