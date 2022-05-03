import "package:flutter/material.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";
import "package:hollyday_land/models/generic_attraction.dart";
import "package:hollyday_land/models/map_objects.dart";
import "package:hollyday_land/providers/location_provider.dart";
import "package:provider/provider.dart";

class MapScreen extends StatefulWidget {
  final MapObjectTypes mapObjectTypes;

  const MapScreen({Key? key, required this.mapObjectTypes}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _controller;
  Set<Marker> markers = {};

  static final CameraPosition _jerusalem = CameraPosition(
    target: LatLng(31.7945578, 35.2392122),
    zoom: 12.4,
  );

  void _onCameraIdle() {
    _controller!.getVisibleRegion().then((bounds) {
      GenericAttraction.forBounds(bounds, widget.mapObjectTypes)
          .then((attractions) {
        final newAttractions = attractions
            .map((attraction) => Marker(
                  markerId: MarkerId(attraction.id.toString()),
                  position: attraction.latLng,
                  infoWindow: InfoWindow(
                      title: attraction.name,
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => attraction.page));
                      }),
                ))
            .toSet();

        setState(() {
          markers = newAttractions;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Ask for location permissions
    Provider.of<LocationProvider>(context, listen: false).retrieveLocation();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.mapObjectTypes == MapObjectTypes.attractions
            ? "Map"
            : "Map of Trails"),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _jerusalem,
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
          // Map is created, manually invoke _onCameraIdle to load the initially
          // shown area
          _onCameraIdle();
        },
        onCameraIdle: _onCameraIdle,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
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
