import 'package:background_location/background_location.dart';
import "package:flutter/material.dart";
import "package:hollyday_land/providers/login.dart";
import "package:hollyday_land/screens/profile.dart";
import "package:provider/provider.dart";

class TrailRecordScreen extends StatefulWidget {
  static const routePath = "/trails/record";

  @override
  State<StatefulWidget> createState() => _TrailRecordScreenState();
}

class _TrailRecordScreenState extends State<TrailRecordScreen> {
  bool isRecording = false;

  void startRecording() {
    BackgroundLocation.setAndroidNotification(
      title: "Notification title",
      message: "Notification message",
      icon: "@mipmap/ic_launcher",
    );
    setState(() {
      isRecording = true;
    });
  }

  void pauseRecording() {
    setState(() {
      isRecording = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);

    if (loginProvider.currentUser == null) {
      return Scaffold(
          appBar: AppBar(
            title: AppBar(
              title: Text("Record trail"),
            ),
          ),
          body: ProfileScreen.loginBody(loginProvider));
    } else {
      return Scaffold(
        appBar: AppBar(title: Text("Record trail")),
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child: Container(height: 50.0),
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
  }
}
