import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

import '../services/api_service.dart';
import '../services/network_service.dart';

class OutdoorMapScreen extends StatefulWidget {
  const OutdoorMapScreen({Key? key}) : super(key: key);

  @override
  _OutdoorMapScreenState createState() => _OutdoorMapScreenState();
}

class _OutdoorMapScreenState extends State<OutdoorMapScreen> {

  List zones = [];
  LatLng? currentLocation;
  String status = "";
  bool isRunning = false;

  double currentZoom = 17;

  @override
  void initState() {
    super.initState();
    initLocation();
    loadZones();
  }

  /// Request permission + get accurate location
  initLocation() async {

    try {

      LocationPermission permission =
      await Geolocator.requestPermission();

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return;
      }

      Position pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );

      setState(() {
        currentLocation = LatLng(pos.latitude, pos.longitude);
      });

    } catch (e) {

      print("Location error: $e");

      setState(() {
        currentLocation = LatLng(13.0827, 80.2707);
      });
    }
  }

  /// Load zones from backend
  loadZones() async {

    try {

      var data = await ApiService.getOutdoorMap();

      setState(() {
        zones = data;
      });

    } catch (e) {

      print("Error loading zones: $e");
    }
  }

  /// Run outdoor accessibility test
  runOutdoorTest() async {

    if (isRunning) return;

    setState(() {
      status = "Running outdoor test...";
      isRunning = true;
    });

    try {

      Position pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );

      double ping = await NetworkService.pingTest();
      double download = await NetworkService.downloadSpeed();
      double api = await NetworkService.apiResponseTime();

      await ApiService.submitTest({

        "mode": "outdoor",

        "building": null,
        "floor": null,
        "zone": null,

        "latitude": pos.latitude,
        "longitude": pos.longitude,

        "ping_ms": ping,
        "download_speed": download,
        "api_response_ms": api,
        "ram_available": 4000,

        "timestamp": DateTime.now().toIso8601String()
      });

      setState(() {
        status = "Outdoor test completed";
        isRunning = false;
      });

      /// reload heatmap
      loadZones();

    } catch (e) {

      print("Outdoor test error: $e");

      setState(() {
        status = "Test failed. Check backend or GPS.";
        isRunning = false;
      });
    }
  }

  Color getColor(String level) {

    if (level == "High") {
      return Colors.green.withOpacity(0.6);
    }

    if (level == "Medium") {
      return Colors.yellow.withOpacity(0.6);
    }

    return Colors.red.withOpacity(0.6);
  }

  @override
  Widget build(BuildContext context) {

    if (currentLocation == null) {

      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(

      appBar: AppBar(
        title: const Text("Outdoor Accessibility Heatmap"),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: isRunning ? null : runOutdoorTest,
        child: const Icon(Icons.speed),
      ),

      body: Column(
        children: [

          if (status.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                status,
                style: const TextStyle(fontSize: 16),
              ),
            ),

          Expanded(
            child: FlutterMap(

              options: MapOptions(
                initialCenter: currentLocation!,
                initialZoom: 17,
                onPositionChanged: (pos, _) {
                  setState(() {
                    currentZoom = pos.zoom ?? 17;
                  });
                },
              ),

              children: [

                TileLayer(
                  urlTemplate:
                  "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                  userAgentPackageName: 'com.example.flutter_app',
                ),

                CircleLayer(

                  circles: zones.map((z) {

                    return CircleMarker(

                      point: LatLng(z["lat"], z["lon"]),

                      radius: 120 / currentZoom,   // bigger circles

                      color: getColor(z["level"]).withOpacity(0.7),

                      borderStrokeWidth: 2,
                      borderColor: Colors.black26,

                    );

                  }).toList(),
                ),

              ],
            ),
          ),

        ],
      ),
    );
  }
}