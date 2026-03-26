import 'package:flutter/material.dart';
import '../services/api_service.dart';

class IndoorVisualizationScreen extends StatefulWidget {

  final String building;
  final String floor;
  final double length;
  final double width;

  const IndoorVisualizationScreen(
      this.building,
      this.floor,
      this.length,
      this.width,
      {Key? key})
      : super(key: key);

  @override
  _IndoorVisualizationScreenState createState() =>
      _IndoorVisualizationScreenState();
}

class _IndoorVisualizationScreenState
    extends State<IndoorVisualizationScreen> {

  Map zones = {};

  @override
  void initState() {
    super.initState();
    loadZones();
  }

  loadZones() async {

    try {

      var data = await ApiService.getIndoorMap(
          widget.building, widget.floor);

      setState(() {
        zones = data;
      });

    } catch (e) {

      print("Indoor map error: $e");
    }
  }

  /// Convert level → numeric score
  double levelToScore(String level) {

    if (level == "High") return 1.0;
    if (level == "Medium") return 0.5;

    return 0.0;
  }

  /// Blend colors red → yellow → green
  Color getColor(String zone) {

    if (!zones.containsKey(zone)) return Colors.grey;

    double score = levelToScore(zones[zone]);

    return Color.lerp(Colors.red, Colors.green, score)!;
  }

  @override
  Widget build(BuildContext context) {

    /// Dynamic grid size
    int rows = (widget.length / 10).ceil();
    int cols = (widget.width / 10).ceil();
    int totalZones = rows * cols;

    return Scaffold(

      appBar: AppBar(
        title: Text(
            "${widget.building} Floor ${widget.floor} Accessibility"),
      ),

      body: Column(

        children: [

          /// Legend Section
          Container(

            padding: const EdgeInsets.all(12),

            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,

              children: const [

                Text(
                  "Accessibility Legend",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),

                SizedBox(height: 6),

                Row(
                  children: [
                    Icon(Icons.square, color: Colors.red),
                    SizedBox(width: 6),
                    Text("Low Accessibility (0.0 – 0.3)")
                  ],
                ),

                Row(
                  children: [
                    Icon(Icons.square, color: Colors.yellow),
                    SizedBox(width: 6),
                    Text("Medium Accessibility (0.3 – 0.7)")
                  ],
                ),

                Row(
                  children: [
                    Icon(Icons.square, color: Colors.green),
                    SizedBox(width: 6),
                    Text("High Accessibility (0.7 – 1.0)")
                  ],
                ),

              ],
            ),
          ),

          /// Dynamic Grid Visualization
          Expanded(

            child: GridView.builder(

              padding: const EdgeInsets.all(10),

              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: cols,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8),

              itemCount: totalZones,

              itemBuilder: (_, i) {

                String zone = "Z${i + 1}";

                return Container(

                  decoration: BoxDecoration(

                    color: getColor(zone),

                    borderRadius: BorderRadius.circular(10),

                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                      )
                    ],

                  ),

                  child: Center(

                    child: Text(

                      zone,

                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),

                    ),
                  ),
                );
              },
            ),
          ),

        ],
      ),
    );
  }
}