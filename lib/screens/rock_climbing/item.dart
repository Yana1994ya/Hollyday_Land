import "package:flutter/material.dart";
import "package:hollyday_land/models/base_attraction.dart";
import 'package:hollyday_land/models/rock_climbing/item.dart';
import "package:hollyday_land/screens/attraction.dart";

class RockClimbingItemScreen extends AttractionScreen<RockClimbingItem> {
  const RockClimbingItemScreen({Key? key, required BaseAttraction attraction})
      : super(key: key, attraction: attraction);

  @override
  Future<RockClimbingItem> readFull() {
    return RockClimbingItem.readAttraction(attraction.id);
  }
}
