import "dart:async";
import "dart:convert";

import "package:archive/archive.dart";
import "package:background_location/background_location.dart";
import "package:csv/csv.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";
import "package:hollyday_land/api_server.dart";
import "package:hollyday_land/models/trail/difficulty.dart";
import "package:hollyday_land/models/upload_error.dart";
import "package:hollyday_land/screens/trail/form.dart";
import "package:hollyday_land/widgets/distance.dart";
import "package:http/http.dart" as http;

class ExportLocation {
  final double latitude;
  final double longitude;
  final double altitude;
  final double accuracy;
  final double time;

  ExportLocation({
    required this.latitude,
    required this.longitude,
    required this.altitude,
    required this.accuracy,
    required this.time,
  });
}

class PointCollector {
  // For elevation gain calculation
  static const comparePoints = 30;

  final List<ExportLocation> _points = List.empty(growable: true);
  final List<double> _altitudes = List.empty(growable: true);

  double _distance = 0;
  double _elevationGain = 0;
  double _elapsedTime = 0;

  double? _lastAvgAltitude;
  bool _justStarted = false;
  double? _lastTime;

  void addPoint(Location _location) {
    // Filter out incomplete locations points
    if (_location.latitude == null ||
        _location.longitude == null ||
        _location.altitude == null ||
        _location.accuracy == null ||
        _location.time == null) {
      return;
    }

    // Convert the received Location item into ExportLocation which
    // is much simpler to work with because it doesn't allow nulls
    final location = ExportLocation(
      latitude: _location.latitude!,
      longitude: _location.longitude!,
      altitude: _location.altitude!,
      accuracy: _location.accuracy!,
      time: _location.time!,
    );

    // If not empty, accumulate distance
    if (_points.isNotEmpty) {
      final lastPoint = _points.last;

      _distance += (Distance.calculateDistanceKM(
            lastPoint.latitude,
            lastPoint.longitude,
            location.latitude,
            location.longitude,
          ) *
          1000.0);

      // Collect the new altitude to the running average list
      _altitudes.add(location.altitude);

      while (_altitudes.length > comparePoints) {
        _altitudes.removeAt(0);
      }

      // Only perform the elevation gain calculations if there are {comparePoints} / 2
      // data points, usually 15, less than that is not useful as altitude is very noisy and
      // inaccurate
      if (_altitudes.length > comparePoints / 2) {
        final avgAltitude =
            _altitudes.reduce((value, element) => value + element) /
                _altitudes.length;

        if (_lastAvgAltitude != null && _lastAvgAltitude! < avgAltitude) {
          _elevationGain += (avgAltitude - _lastAvgAltitude!);
        }

        _lastAvgAltitude = avgAltitude;
      }

      // Ignore the first location.time after a pause and resume button
      // (so we don't count pause time)
      if (!_justStarted && _lastTime != null) {
        _elapsedTime += (location.time - _lastTime!);
      } else {
        _justStarted = false;
      }
    }

    _lastTime = location.time;
    _points.add(location);
  }

  void resume() {
    _justStarted = true;
  }

  double get distance => _distance;

  double get elevationGain => _elevationGain;

  double get elapsedTime => _elapsedTime;

  // Return a copy of the points
  List<ExportLocation> get points => _points.skip(0).toList();

  List<LatLng> get latLng =>
      points.map((l) => LatLng(l.latitude, l.longitude)).toList();

  Future<void> upload(
      String hdToken, NewTrailDescription description, List<int> images) async {
    List<List<dynamic>> result = List.empty(growable: true);

    result.add(["Latitude", "Longitude", "Altitude", "Accuracy", "Time"]);

    for (var point in points) {
      result.add([
        point.latitude,
        point.longitude,
        point.altitude,
        point.accuracy,
        point.time
      ]);
    }

    final csvFile = ListToCsvConverter().convert(result, eol: "\n");
    var stringBytes = utf8.encode(csvFile);
    var gzipBytes = GZipEncoder().encode(stringBytes);

    http.MultipartRequest request = http.MultipartRequest(
      "POST",
      Uri.https(ApiServer.serverName, "attractions/api/trail/upload"),
    );
    request.headers["host"] = ApiServer.serverName;

    /*http.MultipartRequest request = http.MultipartRequest(
      "POST",
      Uri.http("192.168.1.159:8000", "attractions/api/trail/upload"),
    );*/

    request.fields["token"] = hdToken;
    request.fields["name"] = description.name;
    request.fields["difficulty"] = difficultyToString(description.difficulty);
    request.fields["images"] =
        images.map((imageId) => imageId.toString()).join(",");
    request.fields["activities"] =
        description.activities.map((id) => id.toString()).join(",");
    request.fields["attractions"] =
        description.attractions.map((id) => id.toString()).join(",");
    request.fields["suitabilities"] =
        description.suitabilities.map((id) => id.toString()).join(",");

    request.files.add(http.MultipartFile.fromBytes("file", gzipBytes!,
        filename: "point.csv.gz"));

    return request.send().then((response) async {
      if (response.statusCode != 200) {
        // A bit tricky code, convert callback into a future
        Completer<UploadError> result = Completer();

        response.stream.transform(utf8.decoder).listen((body) {
          result.complete(UploadError(response.statusCode, body));
        });

        UploadError error = await result.future;
        throw error;
      }
    });
  }
}
