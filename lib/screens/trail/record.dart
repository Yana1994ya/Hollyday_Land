import "dart:async";

import "package:background_location/background_location.dart";
import "package:flutter/material.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";
import "package:hollyday_land/models/image_upload.dart";
import "package:hollyday_land/models/trail/point_collector.dart";
import "package:hollyday_land/models/upload_error.dart";
import "package:hollyday_land/providers/location_provider.dart";
import "package:hollyday_land/providers/login.dart";
import "package:hollyday_land/screens/profile.dart";
import "package:hollyday_land/screens/trail/form.dart";
import "package:hollyday_land/widgets/image_upload.dart";
import "package:image_picker/image_picker.dart";
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
        body: ProfileScreen.loginBody(context, loginProvider),
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
  bool imageUploading = false;
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
    elapsedTime += 1;

    // Invoke setState only if the widget is mounted
    // this basically means if the screen is turned on.

    // Invoking setState on unmounted widget throws an exception.
    if (mounted) {
      setState(() {});
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
        .push(MaterialPageRoute(builder: (_) => LoadingTrailForm()))
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

  @override
  void initState() {
    super.initState();

    LocationProvider.fetchSnapshot().then((value) {
      setState(() {});
    });

    BackgroundLocation.getLocationUpdates(pointCollector.addPoint);
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Are you sure?"),
            content: Text("Do you want to discard this recording?"),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text("No"),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text("Yes"),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final LocationProvider locationProvider =
        Provider.of<LocationProvider>(context, listen: false);

    final LatLng initialPosition;

    if (locationProvider.lastLocation != null) {
      initialPosition = LatLng(
        locationProvider.lastLocation!.latitude!,
        locationProvider.lastLocation!.longitude!,
      );
    } else {
      initialPosition = LatLng(31.768, 35.213);
    }

    final textTheme = Theme.of(context).textTheme.bodyText2;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Record trail"),
          actions: [
            if (!isRecording && !uploading && !pointCollector.isEmpty)
              TextButton(
                onPressed: upload,
                child: Text(
                  "Upload",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ImageUploadWidget(
              abort: () {
                setState(() {
                  imageUploading = false;
                });
              },
              pickedImage: (XFile picture) async {
                final image =
                    await ImageUpload.uploadImage(picture, widget.hdToken);

                setState(() {
                  images.add(image.imageId);
                  imageUploading = false;
                });
              },
              pickingImage: () {
                setState(() {
                  imageUploading = true;
                });
              },
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: const DecorationImage(
                image: AssetImage("assets/graphics/record_background.jpg"),
                fit: BoxFit.fitWidth,
                alignment: Alignment.bottomCenter),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 300.0,
                  child: GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition:
                        CameraPosition(target: initialPosition, zoom: 15),
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
                Text(
                  isRecording ? "Recording trail" : "Waiting",
                  style: textTheme,
                ),
                Text(
                  "Distance: " +
                      pointCollector.distance.toStringAsFixed(2) +
                      "m",
                  style: textTheme,
                ),
                Text(
                  "Elevation Gain: " +
                      pointCollector.elevationGain.toStringAsFixed(2) +
                      "m",
                  style: textTheme,
                ),
                Text(
                  "Time: " + elapsedTime.toString() + "s",
                  style: textTheme,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Images: " + images.length.toString(),
                      style: textTheme,
                    ),
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: imageUploading
                          ? Padding(
                              padding: EdgeInsets.all(3),
                              child: CircularProgressIndicator(),
                            )
                          : Container(),
                    ),
                  ],
                ),
                isRecording
                    ? ElevatedButton(
                        onPressed: pauseRecording, child: Text("Pause"))
                    : ElevatedButton(
                        onPressed: startRecording, child: Text("Record")),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (controller != null) {
      controller!.dispose();
    }

    BackgroundLocation.stopLocationService();
    super.dispose();
  }
}
