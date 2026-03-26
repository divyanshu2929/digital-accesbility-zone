import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'indoor_grid_screen.dart';

class IndoorSetupScreen extends StatefulWidget {
  const IndoorSetupScreen({Key? key}) : super(key: key);

  @override
  _IndoorSetupScreenState createState() => _IndoorSetupScreenState();
}

class _IndoorSetupScreenState extends State<IndoorSetupScreen> {

  final buildingController = TextEditingController();
  final floorController = TextEditingController();
  final lengthController = TextEditingController();
  final widthController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadSavedData();
  }

  /// Load saved building details
  loadSavedData() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    buildingController.text = prefs.getString("building") ?? "";
    floorController.text = (prefs.getInt("floors") ?? "").toString();
    lengthController.text = (prefs.getDouble("length") ?? "").toString();
    widthController.text = (prefs.getDouble("width") ?? "").toString();

    setState(() {});
  }

  /// Save building details locally
  saveData(String building, int floors, double length, double width) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString("building", building);
    prefs.setInt("floors", floors);
    prefs.setDouble("length", length);
    prefs.setDouble("width", width);
  }

  submit() async {

    String building = buildingController.text;

    int floors = int.parse(floorController.text);
    double length = double.parse(lengthController.text);
    double width = double.parse(widthController.text);

    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> saved = prefs.getStringList("buildings") ?? [];

    saved.add("$building|$floors|$length|$width");

    await prefs.setStringList("buildings", saved);

    Navigator.pop(context);

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(title: const Text("Indoor Setup")),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            TextField(
              controller: buildingController,
              decoration: const InputDecoration(
                labelText: "Building Name",
              ),
            ),

            TextField(
              controller: floorController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Number of Floors",
              ),
            ),

            TextField(
              controller: lengthController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Building Length (meters)",
              ),
            ),

            TextField(
              controller: widthController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Building Width (meters)",
              ),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: submit,
              child: const Text("Generate Grid"),
            )

          ],
        ),
      ),
    );
  }
}