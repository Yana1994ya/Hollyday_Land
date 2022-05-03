import "package:flutter/material.dart";
import "package:location/location.dart";

enum LocationStatus { serviceDisabled, permissionDenied, recieved }

class LocationSnapshot {
  final LocationStatus status;
  final LocationData? location;
  final DateTime acquisitionTime;

  const LocationSnapshot(this.status, this.location, this.acquisitionTime);

  @override
  String toString() {
    return "LocationSnapshot{status: $status, location: $location, acquisitionTime: $acquisitionTime}";
  }
}

class LocationProvider extends ChangeNotifier {
  LocationSnapshot? _lastSnapshot;

  void retrieveLocation() {
    // If location wasn't acquired, or was acquired over 10 minutes ago
    if (_lastSnapshot == null ||
        _lastSnapshot!.acquisitionTime.difference(DateTime.now()).inMinutes >
            10) {
      fetchSnapshot().then((data) {
        _lastSnapshot = data;
        notifyListeners();
      });
    }
  }

  LocationData? get lastLocation {
    return _lastSnapshot?.location;
  }

  static Future<LocationSnapshot> fetchSnapshot() async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return LocationSnapshot(
          LocationStatus.serviceDisabled,
          null,
          DateTime.now(),
        );
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return LocationSnapshot(
          LocationStatus.permissionDenied,
          null,
          DateTime.now(),
        );
      }
    }

    LocationData currentLocation = await location.getLocation();

    return LocationSnapshot(
      LocationStatus.recieved,
      currentLocation,
      DateTime.now(),
    );
  }
}
