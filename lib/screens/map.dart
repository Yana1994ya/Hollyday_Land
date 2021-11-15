import "package:flutter/material.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";

class MapScreen extends StatefulWidget {
  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  GoogleMapController? _controller;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  void _onGeoChanged(CameraPosition position) {
    /*
    print("position: " + position.target.toString());
    print("zoom: " + position.zoom.toString());
    */
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: _kGooglePlex,
      onMapCreated: (GoogleMapController controller) {
        _controller = controller;
      },
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      onCameraMove: _onGeoChanged,
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
