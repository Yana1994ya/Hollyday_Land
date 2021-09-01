import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kHome = CameraPosition(
      bearing: 0,
      target: LatLng(31.82158331714497, 35.25423143059015),
      zoom: 16.58);

  void _onGeoChanged(CameraPosition position) {
    print("position: " + position.target.toString());
    print("zoom: " + position.zoom.toString());
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        onCameraMove: _onGeoChanged,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToHome,
        label: Text('Take me home'),
        icon: Icon(Icons.directions_run),
      ),
    );
  }

  Future<void> _goToHome() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kHome));
  }
}