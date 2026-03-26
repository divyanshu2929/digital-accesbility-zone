import 'dart:math';

class DataPoint {

  double ping;
  double download;
  double api;
  double ram;

  DataPoint(this.ping, this.download, this.api, this.ram);

  List<double> toList() {
    return [ping, download, api, ram];
  }
}

class KMeans {

  int k;
  int maxIterations;

  KMeans({this.k = 3, this.maxIterations = 50});

  List<List<double>> initializeCentroids(List<DataPoint> data) {

    final random = Random();

    List<List<double>> centroids = [];

    for (int i = 0; i < k; i++) {
      centroids.add(data[random.nextInt(data.length)].toList());
    }

    return centroids;
  }

  double distance(List<double> a, List<double> b) {

    double sum = 0;

    for (int i = 0; i < a.length; i++) {
      sum += pow(a[i] - b[i], 2);
    }

    return sqrt(sum);
  }

  int closestCentroid(DataPoint point, List<List<double>> centroids) {

    double minDist = double.infinity;
    int index = 0;

    for (int i = 0; i < centroids.length; i++) {

      double dist = distance(point.toList(), centroids[i]);

      if (dist < minDist) {
        minDist = dist;
        index = i;
      }
    }

    return index;
  }

  List<int> fit(List<DataPoint> data) {

    List<List<double>> centroids = initializeCentroids(data);

    List<int> labels = List.filled(data.length, 0);

    for (int iter = 0; iter < maxIterations; iter++) {

      for (int i = 0; i < data.length; i++) {
        labels[i] = closestCentroid(data[i], centroids);
      }

      List<List<double>> newCentroids =
      List.generate(k, (_) => List.filled(4, 0));

      List<int> counts = List.filled(k, 0);

      for (int i = 0; i < data.length; i++) {

        int cluster = labels[i];

        counts[cluster]++;

        List<double> point = data[i].toList();

        for (int j = 0; j < 4; j++) {
          newCentroids[cluster][j] += point[j];
        }
      }

      for (int i = 0; i < k; i++) {

        if (counts[i] == 0) continue;

        for (int j = 0; j < 4; j++) {
          newCentroids[i][j] /= counts[i];
        }
      }

      centroids = newCentroids;
    }

    return labels;
  }
}

String labelToAccessibility(int label) {

  if (label == 0) return "Low Accessibility";

  if (label == 1) return "Medium Accessibility";

  return "High Accessibility";
}