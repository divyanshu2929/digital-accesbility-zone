class AccessibilityLog {

  String mode;

  String? building;
  String? floor;
  String? zone;

  double? latitude;
  double? longitude;

  double pingMs;
  double downloadSpeed;
  double apiResponseMs;

  double ramAvailable;

  AccessibilityLog({
    required this.mode,
    this.building,
    this.floor,
    this.zone,
    this.latitude,
    this.longitude,
    required this.pingMs,
    required this.downloadSpeed,
    required this.apiResponseMs,
    required this.ramAvailable
  });

  Map<String, dynamic> toJson() {
    return {
      "mode": mode,
      "building": building,
      "floor": floor,
      "zone": zone,
      "latitude": latitude,
      "longitude": longitude,
      "ping_ms": pingMs,
      "download_speed": downloadSpeed,
      "api_response_ms": apiResponseMs,
      "ram_available": ramAvailable
    };
  }
}