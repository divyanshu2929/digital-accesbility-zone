import 'dart:io';

class NetworkService {

  /// Measure DNS ping time
  static Future<double> pingTest() async {

    final stopwatch = Stopwatch()..start();

    try {

      await InternetAddress.lookup("google.com")
          .timeout(const Duration(seconds: 5));

      stopwatch.stop();

      return stopwatch.elapsedMilliseconds.toDouble();

    } catch (e) {

      return 999;
    }
  }

  /// Rough download speed indicator
  static Future<double> downloadSpeed() async {

    final stopwatch = Stopwatch()..start();

    try {

      final request = await HttpClient()
          .getUrl(Uri.parse("https://jsonplaceholder.typicode.com/posts"))
          .timeout(const Duration(seconds: 5));

      final response = await request.close();

      await response.drain();

      stopwatch.stop();

      return 1000 / stopwatch.elapsedMilliseconds;

    } catch (e) {

      return 0;
    }
  }

  /// Measure API response latency
  static Future<double> apiResponseTime() async {

    final stopwatch = Stopwatch()..start();

    try {

      final request = await HttpClient()
          .getUrl(Uri.parse("https://jsonplaceholder.typicode.com/posts/1"))
          .timeout(const Duration(seconds: 5));

      final response = await request.close();

      await response.drain();

      stopwatch.stop();

      return stopwatch.elapsedMilliseconds.toDouble();

    } catch (e) {

      return 999;
    }
  }
}