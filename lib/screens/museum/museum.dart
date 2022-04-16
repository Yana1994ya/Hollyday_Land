import "package:flutter/material.dart";
import "package:hollyday_land/models/dao/base_attraction_short.dart";
import "package:hollyday_land/models/museum/museum.dart";
import "package:hollyday_land/screens/managed_attraction.dart";

class MuseumScreen extends ManagedAttractionScreen<Museum> {
  const MuseumScreen({
    Key? key,
    required AttractionShort attraction,
  }) : super(key: key, attraction: attraction);

  @override
  Future<Museum> readFull(BuildContext context, int cacheKey) {
    return museumObjects.read(attraction.id, cacheKey);
  }

  @override
  List<Widget> extraInformation(Museum attraction, BuildContext context) {
    return [
      SizedBox(height: 5),
      Align(
        child: Text(attraction.domain.name),
        alignment: Alignment.topLeft,
      ),
    ];
  }
}
