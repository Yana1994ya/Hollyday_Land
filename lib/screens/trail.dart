import 'dart:async';
import "dart:math" as math;

import 'package:csv/csv.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import "package:google_maps_flutter/google_maps_flutter.dart";
import "package:hollyday_land/providers/location_provider.dart";
import "package:provider/provider.dart";

class TrailScreen extends StatefulWidget {
  static const routePath = "/trail";

  @override
  State<TrailScreen> createState() => TrailScreenState();
}

class TrailScreenState extends State<TrailScreen> {
  //GoogleMapController? _controller;
  Completer<GoogleMapController> _controller = Completer();

  Set<Polyline> lines = {};

  static final CameraPosition trailStart = CameraPosition(
    target: LatLng(31.77711000, 35.18087000),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    Provider.of<LocationProvider>(context, listen: false).retrieveLocation();

    return Scaffold(
      appBar: AppBar(
        title: Text("Trail"),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: trailStart,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        polylines: lines,
      ),
    );
  }

  /*{

        }*/

  void loadAsset() async {
    final myData = await rootBundle.loadString("assets/trail.csv");
    List<List<dynamic>> rowsAsListOfValues =
        const CsvToListConverter().convert(myData);

    if (rowsAsListOfValues.isEmpty) {
      throw Exception("given csv file is empty");
    }

    final header = rowsAsListOfValues.removeAt(0);
    final indexLatitude = header.indexOf("Latitude");

    if (indexLatitude == -1) {
      throw Exception("Latitude column is missing");
    }

    final indexLongitude = header.indexOf("Longitude");

    if (indexLongitude == -1) {
      throw Exception("Longitude column is missing");
    }

    /*final indexElevation = header.indexOf("Elevation");

    if(indexElevation == -1){
      throw Exception("Elevation column is missing");
    }*/

    List<LatLng> points = rowsAsListOfValues.map((row) {
      return LatLng(row[indexLatitude], row[indexLongitude]);
    }).toList();

    LatLngBounds bound = LatLngBounds(
      southwest: LatLng(points.map((p) => p.latitude).reduce(math.min),
          points.map((p) => p.longitude).reduce(math.min)),
      northeast: LatLng(points.map((p) => p.latitude).reduce(math.max),
          points.map((p) => p.longitude).reduce(math.max)),
    );

    CameraUpdate u2 = CameraUpdate.newLatLngBounds(bound, 50);

    setState(() {
      lines.add(Polyline(
        polylineId: PolylineId("polyline"),
        visible: true,
        color: Colors.lightGreen,
        points: points,
        width: 3,
      ));

      _controller.future.then((value) => value.animateCamera(u2));
    });
  }

  @override
  void initState() {
    loadAsset();
    super.initState();
  }

  @override
  void dispose() {
    _controller.future.then((value) => value.dispose());

    super.dispose();
  }
}
