import "package:flutter/material.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";
import "package:hollyday_land/models/dao/base_attraction.dart";
import "package:maps_launcher/maps_launcher.dart";

class AttractionMap extends StatefulWidget {
  final ManagedAttraction attraction;

  const AttractionMap({Key? key, required this.attraction}) : super(key: key);

  @override
  State<AttractionMap> createState() => AttractionMapState();
}

class AttractionMapState extends State<AttractionMap> {
  CameraPosition get initialCameraPosition {
    return CameraPosition(
      target: LatLng(widget.attraction.lat, widget.attraction.long),
      zoom: 14.4746,
    );
  }

  Marker get attractionMarker {
    return Marker(
      position: LatLng(widget.attraction.lat, widget.attraction.long),
      markerId: MarkerId(widget.attraction.id.toString()),
      infoWindow: InfoWindow(title: widget.attraction.name),
    );
  }

  void launchMap() {
    MapsLauncher.launchCoordinates(
        widget.attraction.lat, widget.attraction.long, widget.attraction.name);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: launchMap,
      child: AbsorbPointer(
        absorbing: true,
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: initialCameraPosition,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          markers: {attractionMarker},
        ),
      ),
    );
  }
}
