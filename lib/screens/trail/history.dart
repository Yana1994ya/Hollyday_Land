import "package:flutter/material.dart";
import "package:hollyday_land/models/trail/short.dart";
import "package:hollyday_land/providers/login.dart";
import "package:hollyday_land/screens/profile.dart";
import "package:hollyday_land/screens/trail/trails.dart";
import "package:provider/provider.dart";

class HistoryTrailsScreen extends StatelessWidget {
  static const routePath = "/history/trails";

  @override
  Widget build(BuildContext context) {
    LoginProvider loginProvider = Provider.of<LoginProvider>(context);

    final Widget body;
    if (loginProvider.hdToken == null) {
      body = ProfileScreen.loginBody(loginProvider);
    } else {
      body = TrailsScreen.trailsWidget(
          TrailShort.readHistory(loginProvider.hdToken!));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Visited trails"),
      ),
      body: body,
    );
  }
}
