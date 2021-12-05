import "package:google_maps_flutter/google_maps_flutter.dart";

mixin WithLocation {
  double get lat;

  double get long;

  LatLng get latLng => LatLng(lat, long);
}
