import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/constants.dart';
import 'screens/backend_setup_screen.dart';
import 'screens/mode_selection_screen.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();

  String? backend = prefs.getString("backend_url");

  if (backend != null) {
    Constants.API_BASE = backend;
  }

  runApp(MyApp(backend == null));
}

class MyApp extends StatelessWidget {

  final bool showSetup;

  const MyApp(this.showSetup, {super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,

      title: 'Digital Accessibility Zones',

      theme: ThemeData(

        brightness: Brightness.dark,

        primaryColor: const Color(0xff6366f1),

        scaffoldBackgroundColor: const Color(0xff0f172a),

        cardColor: const Color(0xff1e293b),

        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
        ),

      ),

      routes: {
        "/home": (context) => ModeSelectionScreen(),
      },

      home: showSetup
          ? const BackendSetupScreen()
          : ModeSelectionScreen(),
    );
  }
}