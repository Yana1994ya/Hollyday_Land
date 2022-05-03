import "dart:async";

import "package:flutter/material.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";
import "package:hollyday_land/models/generic_attraction.dart";
import "package:hollyday_land/models/map_objects.dart";
import "package:hollyday_land/providers/location_provider.dart";
import "package:provider/provider.dart";

class MapScreen extends StatefulWidget {
  static const routePath = "/map";

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _controller;
  Timer? refreshTimer;
  LatLngBounds? bounds;
  Set<Marker> markers = {};
  bool initiated = false;
  late MapObjects objects;

  @override
  void didChangeDependencies() {
    if (!initiated) {
      if (ModalRoute.of(context)!.settings.arguments == null) {
        objects = MapObjects.attractions;
      } else {
        objects = ModalRoute.of(context)!.settings.arguments as MapObjects;
      }

      initiated = true;
    }

    super.didChangeDependencies();
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(31.7945578, 35.2392122),
    zoom: 14.4746,
  );

  void _loadData() {
    final Future<Set<Marker>> markerLoading;

    markerLoading =
        GenericAttraction.forBounds(bounds!, objects).then((attractions) {
      return attractions
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
    });

    markerLoading.then((newMarkers) {
      setState(() {
        markers = newMarkers;
      });
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

      refreshTimer = Timer(Duration(milliseconds: 1200), _loadData);
    });
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<LocationProvider>(context, listen: false).retrieveLocation();
    return Scaffold(
      appBar: AppBar(
        title:
            Text(objects == MapObjects.attractions ? "Map" : "Map of Trails"),
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
