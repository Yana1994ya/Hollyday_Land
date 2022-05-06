import "package:flutter/material.dart";
import "package:hollyday_land/widgets/no_results.dart";

class ToursUnavailableScreen extends StatelessWidget {
  static const routePath = "/tours";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tours"),
      ),
      body: NoResults(
        text: "Coming soon",
        subTitle: "This feature is currently under development",
      ),
    );
  }
}
