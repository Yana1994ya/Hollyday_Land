import "package:flutter/material.dart";
import "package:hollyday_land/models/base_attraction.dart";
import "package:hollyday_land/models/winery/winery.dart";
import "package:hollyday_land/screens/attraction.dart";

class WineryScreen extends AttractionScreen<Winery> {
  const WineryScreen({Key? key, required BaseAttraction attraction})
      : super(key: key, attraction: attraction);

  @override
  Future<Winery> readFull() {
    return Winery.readWinery(attraction.id);
  }
}
