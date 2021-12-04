import "package:flutter/material.dart";
import "package:hollyday_land/models/base_attraction.dart";
import "package:hollyday_land/models/offroad/offroad.dart";
import "package:hollyday_land/screens/attraction.dart";

class OffRoadTripScreen extends AttractionScreen<OffRoadTrip> {
  const OffRoadTripScreen({Key? key, required BaseAttraction attraction})
      : super(key: key, attraction: attraction);

  @override
  Future<OffRoadTrip> readFull() {
    return OffRoadTrip.readTrip(attraction.id);
  }
}
