import 'dart:async';

import "package:flutter/material.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";
import 'package:hollyday_land/api_server.dart';
import "package:hollyday_land/providers/location_provider.dart";
import "package:provider/provider.dart";

class MapScreen extends StatefulWidget {
  static const routePath = "/map";

  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  GoogleMapController? _controller;
  Timer? refreshTimer;
  LatLngBounds? bounds;
  Set<Marker> markers = {};

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(31.7945578, 35.2392122),
    zoom: 14.4746,
  );

  void _loadData() {
    print("load data for bounds:" + bounds.toString());
    final Map<String, Iterable<String>> params = {};
    params["lat_min"] = [bounds!.southwest.latitude.toStringAsPrecision(10)];
    params["lon_min"] = [bounds!.southwest.longitude.toStringAsPrecision(10)];
    params["lat_max"] = [bounds!.northeast.latitude.toStringAsPrecision(10)];
    params["lon_max"] = [bounds!.northeast.longitude.toStringAsPrecision(10)];

    print(params);

    ApiServer.get("/attractions/api/map", "attractions", params).then((values) {
      Set<Marker> newMarkers = {};

      for (Map<String, dynamic> attraction in (values as List<dynamic>)) {
        final String type = attraction["type"];
        final int id = attraction["id"];

        newMarkers.add(Marker(
            markerId: MarkerId("${type}_$id"),
            position: LatLng(attraction["lat"], attraction["long"]),
            infoWindow: InfoWindow(title: attraction["name"])));

        setState(() {
          markers = newMarkers;
        });
      }
    });
  }

  void _onGeoChanged(CameraPosition position) {
    if (refreshTimer != null) {
      refreshTimer!.cancel();
      refreshTimer = null;
    }

    _controller!.getVisibleRegion().then((bounds) {
      this.bounds = bounds;

      if (refreshTimer != null) {
        refreshTimer!.cancel();
      }

      refreshTimer = Timer(Duration(seconds: 3), _loadData);
    });
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<LocationProvider>(context, listen: false).retrieveLocation();
    return Scaffold(
      appBar: AppBar(
        title: Text("Map"),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        onCameraMove: _onGeoChanged,
        markers: markers,
      ),
    );
  }

  @override
  void dispose() {
    if (_controller != null) {
      _controller!.dispose();
    }

    super.dispose();
  }
}
