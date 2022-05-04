import "package:flutter/material.dart";
import "package:hollyday_land/models/trail/difficulty.dart";
import "package:hollyday_land/models/trail/short.dart";
import "package:hollyday_land/screens/trail/trail.dart";
import "package:hollyday_land/widgets/list_item.dart";

class TrailListItem extends AttractionListItem<TrailShort> {
  const TrailListItem({Key? key, required TrailShort attraction})
      : super(key: key, attraction: attraction);

  @override
  List<Widget> extraInformation(BuildContext context) {
    return [
      Align(
        child: Text(
          "Difficulty: " +
              difficultyToDescription(attraction.difficulty) +
              ", distance: " +
              (attraction.length.toDouble() / 1000.0).toStringAsFixed(2) +
              "km" +
              ", elv gain: " +
              attraction.elevationGain.toString() +
              "m",
        ),
        alignment: Alignment.topLeft,
      )
    ];
  }

  @override
  MaterialPageRoute get pageRoute =>
      MaterialPageRoute(builder: (_) => TrailScreen(attraction: attraction));
}
