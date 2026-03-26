import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

class DeviceService {

  static Future<Map<String, dynamic>> getDeviceInfo() async {

    final deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {

      AndroidDeviceInfo android = await deviceInfo.androidInfo;

      return {

        "device_model": android.model,
        "android_version": android.version.release,
        "cpu_architecture": android.supportedAbis.first,

      };

    }

    return {};
  }

}