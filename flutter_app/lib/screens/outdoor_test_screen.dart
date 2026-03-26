import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../services/network_service.dart';
import '../services/api_service.dart';

class OutdoorTestScreen extends StatefulWidget {
  const OutdoorTestScreen({Key? key}) : super(key: key);

  @override
  _OutdoorTestScreenState createState() => _OutdoorTestScreenState();
}

class _OutdoorTestScreenState extends State<OutdoorTestScreen> {

  String status = "Ready";

  runOutdoorTest() async {

    setState(() {
      status = "Getting GPS...";
    });

    Position pos = await Geolocator.getCurrentPosition();

    setState(() {
      status = "Running network test...";
    });

    double ping = await NetworkService.pingTest();
    double download = await NetworkService.downloadSpeed();
    double api = await NetworkService.apiResponseTime();

    await ApiService.submitTest({

      "mode": "outdoor",

      "latitude": pos.latitude,
      "longitude": pos.longitude,

      "building": null,
      "floor": null,
      "zone": null,

      "ping_ms": ping,
      "download_speed": download,
      "api_response_ms": api,
      "ram_available": 4000
    });

    setState(() {
      status = "Outdoor test completed";
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("Outdoor Accessibility Test")),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text(status),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: runOutdoorTest,
              child: const Text("Run Outdoor Test"),
            )
          ],
        ),
      ),
    );
  }
}