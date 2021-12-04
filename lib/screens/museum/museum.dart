import "package:flutter/material.dart";
import "package:hollyday_land/models/base_attraction.dart";
import "package:hollyday_land/models/museum/museum.dart";
import "package:hollyday_land/screens/attraction.dart";

class MuseumScreen extends AttractionScreen<Museum> {
  const MuseumScreen({Key? key, required BaseAttraction attraction})
      : super(key: key, attraction: attraction);

  @override
  Future<Museum> readFull() {
    return Museum.readMuseum(attraction.id);
  }
}
