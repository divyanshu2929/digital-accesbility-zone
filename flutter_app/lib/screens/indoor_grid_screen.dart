import 'package:flutter/material.dart';
import 'run_test_screen.dart';

class IndoorGridScreen extends StatelessWidget {

  final String building;
  final String floor;
  final double length;
  final double width;

  const IndoorGridScreen(
      this.building,
      this.floor,
      this.length,
      this.width,
      {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    int rows = (length / 10).ceil();
    int cols = (width / 10).ceil();

    int totalZones = rows * cols;

    return Scaffold(

      appBar: AppBar(
        title: Text("$building Grid"),
      ),

      body: GridView.builder(

        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: cols,
        ),

        itemCount: totalZones,

        itemBuilder: (context, index) {

          String zone = "Z${index + 1}";

          return GestureDetector(

            onTap: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => RunTestScreen(building, floor, zone, length, width),
                ),
              );
            },

            child: Container(

              margin: const EdgeInsets.all(6),

              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(8),
              ),

              child: Center(
                child: Text(
                  zone,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}