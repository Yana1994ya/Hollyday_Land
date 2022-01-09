import "dart:async";
import "dart:io";
import "dart:math" as math;

import "package:csv/csv.dart";
import "package:flutter/material.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";
import "package:hollyday_land/models/trail/short.dart";
import "package:hollyday_land/models/trail/trail.dart";
import "package:hollyday_land/providers/location_provider.dart";
import "package:http/http.dart" as http;
import "package:provider/provider.dart";

class _TrailWithPoints {
  final Trail trail;
  final List<LatLng> points;

  _TrailWithPoints({
    required this.trail,
    required this.points,
  });
}

class TrailScreen extends StatelessWidget {
  final TrailShort trail;

  const TrailScreen({Key? key, required this.trail}) : super(key: key);

  static Future<_TrailWithPoints> _resolvePoints(Trail trail) async {
    final uri = Uri.parse(trail.points);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      List<List<dynamic>> rows =
          const CsvToListConverter().convert(response.body, eol: "\n");

      if (rows.isEmpty) {
        throw Exception("given csv file is empty");
      }

      final header = rows.removeAt(0);
      final indexLatitude = header.indexOf("Latitude");

      if (indexLatitude == -1) {
        throw Exception("Latitude column is missing");
      }

      final indexLongitude = header.indexOf("Longitude");

      if (indexLongitude == -1) {
        throw Exception("Longitude column is missing");
      }

      List<LatLng> points = rows.map((row) {
        return LatLng(row[indexLatitude], row[indexLongitude]);
      }).toList();

      return _TrailWithPoints(trail: trail, points: points);
    } else {
      throw HttpException(
        "failed to load data, status: ${response.statusCode}",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Ask for permission to get location, ask early to improve user experience
    Provider.of<LocationProvider>(context, listen: false).retrieveLocation();

    return Scaffold(
        appBar: AppBar(
          title: Text(trail.name),
        ),
        body: FutureBuilder(
          future: Trail.readTrail(trail.id).then(_resolvePoints),
          builder: (BuildContext _, AsyncSnapshot<_TrailWithPoints> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error!.toString()));
            } else if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              return _TrailScreenBody(trailAndPoints: snapshot.data!);
            }
          },
        ));
  }
}

// Everything is loaded
class _TrailScreenBody extends StatefulWidget {
  final _TrailWithPoints trailAndPoints;

  const _TrailScreenBody({
    Key? key,
    required this.trailAndPoints,
  }) : super(key: key);

  @override
  State<_TrailScreenBody> createState() => _TrailScreenBodyState();
}

class _TrailScreenBodyState extends State<_TrailScreenBody> {
  GoogleMapController? controller;

  CameraUpdate trailCamera() {
    LatLngBounds bound = LatLngBounds(
      southwest: LatLng(
        widget.trailAndPoints.points.map((p) => p.latitude).reduce(math.min),
        widget.trailAndPoints.points.map((p) => p.longitude).reduce(math.min),
      ),
      northeast: LatLng(
        widget.trailAndPoints.points.map((p) => p.latitude).reduce(math.max),
        widget.trailAndPoints.points.map((p) => p.longitude).reduce(math.max),
      ),
    );

    return CameraUpdate.newLatLngBounds(bound, 50);
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition:
          CameraPosition(target: widget.trailAndPoints.points.first, zoom: 13),
      onMapCreated: (GoogleMapController controller) {
        this.controller = controller;
        controller.animateCamera(trailCamera());
      },
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      polylines: {
        Polyline(
          polylineId: PolylineId("trail"),
          visible: true,
          color: Colors.lightGreen,
          points: widget.trailAndPoints.points,
          width: 3,
        )
      },
    );
  }

  @override
  void dispose() {
    if (controller != null) {
      controller!.dispose();
    }

    super.dispose();
  }
}
