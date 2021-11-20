import "package:flutter/material.dart";
import "package:hollyday_land/models/museum/museum.dart";
import "package:hollyday_land/models/museum/short.dart";
import "package:hollyday_land/screens/attraction.dart";

class MuseumScreen extends AttractionScreen<MuseumShort, Museum> {
  const MuseumScreen({Key? key, required MuseumShort museum})
      : super(key: key, attraction: museum);

  @override
  Future<Museum> readFull() {
    return Museum.readMuseum(attraction.id);
  }
}
