import "package:flutter/material.dart";
import "package:location/location.dart";

class LocationWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LocationWidgetState();
  }
}

enum LocationStatus { serviceDisabled, permissionDenied, trackingStarted }

class Datum {
  final int time;
  final double long, lat, accuracy;

  Datum(this.time, this.long, this.lat, this.accuracy);
}

class _LocationWidgetState extends State<LocationWidget> {
  bool recording = false;
  bool writing = false;
  List<Datum> recordedData = List.empty(growable: true);

  Future<LocationStatus> getLocation() async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return LocationStatus.serviceDisabled;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return LocationStatus.permissionDenied;
      }
    }

    location.enableBackgroundMode(enable: true);
    location.onLocationChanged.listen((LocationData currentLocation) {
      if (recording) {
        // Use current location
        //print(
        //    "location ${currentLocation.latitude}, ${currentLocation.longitude}");
        setState(() {
          if (currentLocation.longitude != null &&
              currentLocation.latitude != null) {
            recordedData.add(Datum(
                DateTime.now().millisecondsSinceEpoch,
                currentLocation.longitude!,
                currentLocation.latitude!,
                currentLocation.accuracy!));
          }
        });
      }
    });

    return LocationStatus.trackingStarted;
  }

  void _startRecording() {
    setState(() {
      recording = true;
    });
  }

  void _uploadRecorded() {
    setState(() {
      recording = false;
      writing = true;
    });
  }

  Widget status() {
    if (!writing) {
      if (!recording) {
        return Column(
          children: [
            Text("not recording"),
            ElevatedButton(onPressed: _startRecording, child: Text("record"))
          ],
        );
      } else {
        return Column(
          children: [
            Text("recording ${recordedData.length} data"),
            ElevatedButton(
                onPressed: _uploadRecorded, child: Text("upload recorded"))
          ],
        );
      }
    } else {
      return Text("writing to file");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("tracking")),
      body: FutureBuilder<LocationStatus>(
        future: getLocation(),
        builder:
            (BuildContext context, AsyncSnapshot<LocationStatus> snapshot) {
          if (snapshot.hasError) {
            return Text("has error");
          } else if (snapshot.hasData) {
            if (snapshot.data == LocationStatus.serviceDisabled) {
              return Text("service disabled");
            } else if (snapshot.data == LocationStatus.permissionDenied) {
              return Text("permission denied");
            } else if (snapshot.data == LocationStatus.trackingStarted) {
              return status();
            }
          }

          return Text("loading");
        },
      ),
    );
  }
}
