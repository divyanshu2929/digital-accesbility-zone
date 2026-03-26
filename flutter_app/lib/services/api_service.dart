import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/constants.dart';

class ApiService {

  /// Submit accessibility test result
  static Future<Map<String, dynamic>> submitTest(
      Map<String, dynamic> data) async {

    final response = await http.post(
      Uri.parse("${Constants.API_BASE}/submit-test"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to submit test");
    }
  }

  /// Get clustered zones
  static Future<List<dynamic>> getZones() async {

    final response =
    await http.get(Uri.parse("${Constants.API_BASE}/zones"));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to fetch zones");
    }
  }

  /// Get indoor accessibility map
  static Future<Map<String, dynamic>> getIndoorMap(
      String building, String floor) async {

    final response = await http.get(
      Uri.parse("${Constants.API_BASE}/indoor-map/$building/$floor"),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load indoor map");
    }
  }

  /// Get outdoor accessibility map
  static Future<List<dynamic>> getOutdoorMap() async {

    final response =
    await http.get(Uri.parse("${Constants.API_BASE}/outdoor-map"));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load outdoor map");
    }
  }

  /// Get analytics stats
  static Future<Map<String, dynamic>> getStats() async {

    final response =
    await http.get(Uri.parse("${Constants.API_BASE}/stats"));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to fetch stats");
    }
  }
}