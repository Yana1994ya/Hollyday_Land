import 'dart:convert';

import 'package:archive/archive.dart';
import 'package:background_location/background_location.dart';
import 'package:csv/csv.dart';
import "package:flutter/material.dart";
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hollyday_land/api_server.dart';
import "package:hollyday_land/providers/login.dart";
import "package:hollyday_land/screens/profile.dart";
import 'package:hollyday_land/widgets/distance.dart';
import "package:http/http.dart" as http;
import "package:provider/provider.dart";

class TrailRecordScreen extends StatefulWidget {
  static const routePath = "/trails/record";

  @override
  State<StatefulWidget> createState() => _TrailRecordScreenState();
}

class _Location {
  final double latitude;
  final double longitude;
  final double altitude;
  final double accuracy;
  final double time;

  _Location({
    required this.latitude,
    required this.longitude,
    required this.altitude,
    required this.accuracy,
    required this.time,
  });
}

class _TrailRecordScreenState extends State<TrailRecordScreen> {
  bool isRecording = false;
  bool uploading = false;
  List<_Location> points = List.empty(growable: true);
  double distance = 0;
  double elevationGain = 0;
  double lastTime = 0;
  double elapsedTime = 0;
  bool justStarted = false;
  GoogleMapController? controller;

  void startRecording() {
    justStarted = true;
    BackgroundLocation.setAndroidConfiguration(1000);
    BackgroundLocation.startLocationService(distanceFilter: 0.5);

    setState(() {
      isRecording = true;
    });
  }

  void pauseRecording() {
    BackgroundLocation.stopLocationService();

    setState(() {
      isRecording = false;
    });
  }

  void onLocation(Location location) {
    // Don't collect partial location data, since it's of dubious value
    if (location.latitude != null &&
        location.longitude != null &&
        location.altitude != null &&
        location.accuracy != null &&
        location.time != null) {
      if (points.isNotEmpty) {
        final lastPoint = points.last;

        // Register elevation gain
        if (location.altitude! > lastPoint.altitude) {
          elevationGain += location.altitude! - lastPoint.altitude;
        }

        distance += (Distance.calculateDistanceKM(
              lastPoint.latitude,
              lastPoint.longitude,
              location.latitude!,
              location.longitude!,
            ) *
            1000.0);

        if (justStarted) {
          justStarted = false;
        } else {
          elapsedTime += location.time! - lastPoint.time;
        }
      }

      points.add(_Location(
          longitude: location.longitude!,
          latitude: location.latitude!,
          altitude: location.altitude!,
          accuracy: location.accuracy!,
          time: location.time!));

      if (location.time! - lastTime > 10 * 1000) {
        setState(() {
          lastTime = location.time!;

          controller?.animateCamera(CameraUpdate.newLatLngZoom(
            LatLng(location.latitude!, location.longitude!),
            17.0,
          ));
        });
      }
    }
  }

  void reset() {
    setState(() {
      uploading = false;
      points.clear();
      distance = 0;
      elevationGain = 0;
      lastTime = 0;
      elapsedTime = 0;
      justStarted = false;
    });
  }

  void upload() {
    setState(() {
      uploading = true;
    });

    List<List<dynamic>> result = List.empty(growable: true);

    result.add(["Latitude", "Longitude", "Altitude", "Accuracy", "Time"]);

    points.forEach((point) {
      result.add([
        point.latitude,
        point.longitude,
        point.altitude,
        point.accuracy,
        point.time
      ]);
    });

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

    request.fields["token"] =
        Provider.of<LoginProvider>(context, listen: false).hdToken!;
    request.files.add(http.MultipartFile.fromBytes("file", gzipBytes!,
        filename: "point.csv.gz"));

    request.send().then((response) {
      if (response.statusCode != 200) {
        response.stream.transform(utf8.decoder).listen((body) {
          print(body);
        });

        setState(() {
          uploading = false;
        });
      } else {
        reset();
      }
    });
  }

  @override
  void initState() {
    BackgroundLocation.getLocationUpdates(onLocation);
  }

  List<LatLng> listPoint() {
    return points.map((l) => LatLng(l.latitude, l.longitude)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);

    if (loginProvider.currentUser == null) {
      return Scaffold(
          appBar: AppBar(
            title: Text("Record trail"),
          ),
          body: ProfileScreen.loginBody(loginProvider));
    } else {
      return Scaffold(
        appBar: AppBar(title: Text("Record trail")),
        body: Column(
          children: [
            isRecording ? Text("Recording trail") : Text("Waiting"),
            Text("Distance: " + distance.toStringAsFixed(2) + "m"),
            Text("Elevation Gain: " + elevationGain.toStringAsFixed(2) + "m"),
            Text("Time: " + (elapsedTime / 1000).toStringAsFixed(2) + "s"),
            Container(
              width: double.infinity,
              height: 300.0,
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition:
                    CameraPosition(target: LatLng(0, 0), zoom: 15),
                onMapCreated: (GoogleMapController controller) {
                  this.controller = controller;
                },
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                polylines: {
                  Polyline(
                    polylineId: PolylineId("trail"),
                    visible: true,
                    color: Colors.lightGreen,
                    points: listPoint(),
                    width: 3,
                  )
                },
              ),
            ),
            if (!isRecording && !uploading)
              TextButton(onPressed: upload, child: Text("Upload"))
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child: Container(
            height: 50.0,
          ),
        ),
        floatingActionButton: !isRecording
            ? FloatingActionButton(
                onPressed: startRecording,
                tooltip: "Record",
                child: const Icon(Icons.fiber_manual_record),
              )
            : FloatingActionButton(
                onPressed: pauseRecording,
                tooltip: "Pause",
                child: const Icon(Icons.pause),
              ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      );
    }
  }

  @override
  void dispose() {
    if (controller != null) {
      controller!.dispose();
    }

    super.dispose();
  }
}
