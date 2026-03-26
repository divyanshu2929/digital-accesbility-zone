import 'package:flutter/material.dart';
import '../services/network_service.dart';
import '../services/api_service.dart';
import 'indoor_visualization_screen.dart';
import '../services/device_service.dart';

class RunTestScreen extends StatefulWidget {

  final String building;
  final String floor;
  final String zone;
  final double length;
  final double width;

  const RunTestScreen(
      this.building,
      this.floor,
      this.zone,
      this.length,
      this.width,
      {Key? key}
      ) : super(key: key);

  @override
  _RunTestScreenState createState() => _RunTestScreenState();
}

class _RunTestScreenState extends State<RunTestScreen> {

  String status = "Ready";
  String result = "";
  bool isRunning = false;

  Future<void> runTest() async {

    var device = await DeviceService.getDeviceInfo();

    if (isRunning) return;

    setState(() {
      status = "Running test...";
      result = "";
      isRunning = true;
    });

    try {

      /// Run network tests
      double ping = await NetworkService.pingTest();
      double download = await NetworkService.downloadSpeed();
      double api = await NetworkService.apiResponseTime();

      print("Sending data to backend...");

      await ApiService.submitTest({

        "mode": "indoor",

        "building": widget.building,
        "floor": widget.floor,
        "zone": widget.zone,

        "latitude": null,
        "longitude": null,

        "ping_ms": ping,
        "download_speed": download,
        "api_response_ms": api,
        "ram_available": 4000,

        "device_model": device["device_model"],
        "android_version": device["android_version"],
        "cpu_architecture": device["cpu_architecture"],

        "timestamp": DateTime.now().toIso8601String()
      });

      print("Backend request successful");

      setState(() {

        status = "Test Completed";

        result =
        "Ping: ${ping.toStringAsFixed(2)} ms\n"
            "Download: ${download.toStringAsFixed(2)} Mbps\n"
            "API: ${api.toStringAsFixed(2)} ms";

        isRunning = false;
      });

      /// Go to visualization
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => IndoorVisualizationScreen(
            widget.building,
            widget.floor,
            widget.length,
            widget.width,
          ),
        ),
      );

    } catch (e) {

      print("Backend error: $e");

      setState(() {

        status = "Test Failed";

        result =
        "Unable to connect to backend.\nCheck server or WiFi.";

        isRunning = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Run Accessibility Test"),
      ),

      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text(
              status,
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 20),

            if (isRunning)
              const CircularProgressIndicator(),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: isRunning ? null : runTest,
              child: const Text("Run Test"),
            ),

            const SizedBox(height: 20),

            Text(
              result,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),

          ],
        ),
      ),
    );
  }
}