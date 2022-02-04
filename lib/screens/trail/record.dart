import "dart:async";

import "package:background_location/background_location.dart";
import "package:flutter/material.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";
import "package:hollyday_land/models/trail/point_collector.dart";
import "package:hollyday_land/providers/image_upload.dart";
import "package:hollyday_land/providers/login.dart";
import "package:hollyday_land/screens/profile.dart";
import "package:hollyday_land/screens/trail/form.dart";
import "package:image_picker/image_picker.dart";
import "package:location/location.dart" as loc;
import "package:provider/provider.dart";

class TrailRecordScreen extends StatelessWidget {
  static const routePath = "/trails/record";

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);

    if (loginProvider.hdToken == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Record trail"),
        ),
        body: ProfileScreen.loginBody(loginProvider),
      );
    } else {
      return _LoggedInTrailRecordScreen(
        hdToken: loginProvider.hdToken!,
      );
    }
  }
}

class _LoggedInTrailRecordScreen extends StatefulWidget {
  final String hdToken;

  const _LoggedInTrailRecordScreen({Key? key, required this.hdToken})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoggedInTrailRecordScreenState();
}

class _LoggedInTrailRecordScreenState
    extends State<_LoggedInTrailRecordScreen> {
  bool isRecording = false;
  bool uploading = false;
  final pointCollector = PointCollector();
  late Timer? timer;
  int elapsedTime = 0;
  GoogleMapController? controller;
  List<int> images = List.empty(growable: true);

  void startRecording() {
    pointCollector.resume();
    BackgroundLocation.setAndroidConfiguration(1000);
    BackgroundLocation.startLocationService(distanceFilter: 0.5);

    timer = Timer.periodic(Duration(seconds: 1), updateScreen);

    setState(() {
      isRecording = true;
    });
  }

  void pauseRecording() {
    BackgroundLocation.stopLocationService();

    timer!.cancel();
    timer = null;

    setState(() {
      isRecording = false;
    });
  }

  void updateScreen(Timer timer) {
    if (mounted) {
      setState(() {
        elapsedTime += 1;
      });
    }
  }

  void uploadSuccessful(void _) {
    // Let the user know their upload was successful
    showDialog(
      context: context,
      builder: (BuildContext buildContext) {
        return AlertDialog(
          title: const Text("Upload successful"),
          content: Text("The trail was successfully uploaded"),
          actions: [
            TextButton(
              child: const Text("Confirm"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    ).then((_) {
      // Then exit the record screen upon completion
      // Notify the caller a refresh is recommended
      Navigator.of(context).pop(true);
    });
  }

  void uploadFailed(dynamic error) {
    final String message;

    if (error is UploadError) {
      message = "Failed with status ${error.status}, message:${error.cause}";
    } else {
      message = error.toString();
    }

    // Let the user know upload failed
    showDialog(
      context: context,
      builder: (BuildContext buildContext) {
        return AlertDialog(
          title: const Text("Upload failed"),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text("Confirm"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    ).then((_) {
      // Allow them to re-try at a later date
      setState(() {
        uploading = false;
      });
    });
  }

  void upload() {
    setState(() {
      uploading = true;
    });

    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => NewTrailForm()))
        .then((description) {
      // If description == null meaning user closed the form without filling
      // data, in that case, just quite the upload process without doing
      // upload (by flipping the state back to false)
      if (description == null) {
        setState(() {
          uploading = false;
        });
      } else {
        pointCollector
            .upload(widget.hdToken, description as NewTrailDescription, images)
            .then(uploadSuccessful)
            .catchError(uploadFailed);
      }
    });
  }

  _getLocation() async {
    final location = loc.Location();
    final currentLocation = await location.getLocation();

    print("locationLatitude: ${currentLocation.latitude}");
    print("locationLongitude: ${currentLocation.longitude}");
    //rebuild the widget after getting the current location of the user
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getLocation();
    BackgroundLocation.getLocationUpdates(pointCollector.addPoint);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Record trail"),
        actions: [
          if (isRecording)
            IconButton(
                onPressed: () async {
                  // Pick multiple images
                  final ImagePicker _picker = ImagePicker();
                  _picker
                      .pickImage(
                    source: ImageSource.camera,
                    imageQuality: 80,
                    maxWidth: 3840,
                    maxHeight: 2160,
                  )
                      .then((picture) async {
                    if (picture != null) {
                      final imageId = await ImageUpload.uploadImage(
                          picture, widget.hdToken);

                      setState(() {
                        images.add(imageId);
                      });
                    }
                  });
                },
                icon: Icon(Icons.camera))
        ],
      ),
      body: Column(
        children: [
          isRecording ? Text("Recording trail") : Text("Waiting"),
          Text("Distance: " + pointCollector.distance.toStringAsFixed(2) + "m"),
          Text("Elevation Gain: " +
              pointCollector.elevationGain.toStringAsFixed(2) +
              "m"),
          Text("Time: " + elapsedTime.toString() + "s"),
          Text("Images: " + images.length.toString()),
          Container(
            width: double.infinity,
            height: 300.0,
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition:
                  CameraPosition(target: LatLng(0, 0), zoom: 15),
              onMapCreated: (GoogleMapController controller) {
                this.controller = controller;
              },
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              polylines: {
                Polyline(
                  polylineId: PolylineId("trail"),
                  visible: true,
                  color: Colors.lightGreen,
                  points: pointCollector.latLng,
                  width: 3,
                ),
              },
            ),
          ),
          if (!isRecording && !uploading)
            TextButton(onPressed: upload, child: Text("Upload"))
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: 50.0,
        ),
      ),
      floatingActionButton: !isRecording
          ? FloatingActionButton(
              onPressed: startRecording,
              tooltip: "Record",
              child: const Icon(Icons.fiber_manual_record),
            )
          : FloatingActionButton(
              onPressed: pauseRecording,
              tooltip: "Pause",
              child: const Icon(Icons.pause),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  @override
  void dispose() {
    if (controller != null) {
      controller!.dispose();
    }

    super.dispose();
  }
}
