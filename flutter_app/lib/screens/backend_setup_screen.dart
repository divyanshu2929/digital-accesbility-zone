import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/constants.dart';

class BackendSetupScreen extends StatefulWidget {
  const BackendSetupScreen({Key? key}) : super(key: key);

  @override
  State<BackendSetupScreen> createState() => _BackendSetupScreenState();
}

class _BackendSetupScreenState extends State<BackendSetupScreen> {

  final controller = TextEditingController();

  save() async {

    String ip = controller.text.trim();

    String url = "http://$ip:8000";

    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString("backend_url", url);

    Constants.API_BASE = url;

    Navigator.pushReplacementNamed(context, "/home");
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Backend Setup"),
      ),

      body: Padding(

        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            const Text(
              "Enter Backend IP Address",
              style: TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: "192.168.0.3",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: save,
              child: const Text("Connect"),
            )

          ],
        ),
      ),
    );
  }
}