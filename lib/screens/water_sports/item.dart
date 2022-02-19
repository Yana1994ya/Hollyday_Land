import "package:flutter/material.dart";
import "package:hollyday_land/models/base_attraction.dart";
import "package:hollyday_land/models/water_sports/item.dart";
import "package:hollyday_land/screens/attraction.dart";

class WaterSportsItemScreen extends AttractionScreen<WaterSportsItem> {
  const WaterSportsItemScreen({Key? key, required BaseAttraction attraction})
      : super(key: key, attraction: attraction);

  @override
  Future<WaterSportsItem> readFull() {
    return WaterSportsItem.readAttraction(attraction.id);
  }
}
