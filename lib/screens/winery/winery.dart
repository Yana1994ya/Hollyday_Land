import "package:flutter/material.dart";
import "package:hollyday_land/models/winery/winery.dart";
import "package:hollyday_land/models/winery/winery_short.dart";
import "package:hollyday_land/screens/attraction.dart";

class WineryScreen extends AttractionScreen<WineryShort, Winery> {
  const WineryScreen({Key? key, required WineryShort winery})
      : super(key: key, attraction: winery);

  @override
  Future<Winery> readFull() {
    return Winery.readWinery(attraction.id);
  }
}
