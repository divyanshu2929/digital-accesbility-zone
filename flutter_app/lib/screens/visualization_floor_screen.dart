import 'package:flutter/material.dart';
import 'indoor_visualization_screen.dart';

class VisualizationFloorScreen extends StatelessWidget {

  final String building;
  final int floors;
  final double length;
  final double width;

  const VisualizationFloorScreen(
      this.building,
      this.floors,
      this.length,
      this.width,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text("$building Floors"),
      ),

      body: ListView.builder(

        itemCount: floors,

        itemBuilder: (_, i) {

          String floor = "F${i + 1}";

          return ListTile(

            title: Text("Floor ${i + 1}"),

            trailing: const Icon(Icons.arrow_forward),

            onTap: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => IndoorVisualizationScreen(
                    building,
                    floor,
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