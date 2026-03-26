double normalize(double value) {

  return value / 100;
}

double computeScore({
  required double ping,
  required double download,
  required double api,
  required double ram
}) {

  double networkScore =
      normalize(download) - normalize(ping);

  double deviceScore = normalize(ram);

  double appScore = normalize(api);

  return 0.5 * networkScore +
      0.3 * deviceScore +
      0.2 * appScore;
}