import "package:flutter/material.dart";
import "package:hollyday_land/models/zoo/short.dart";
import "package:hollyday_land/models/zoo/zoo.dart";
import "package:hollyday_land/screens/attraction.dart";

class ZooScreen extends AttractionScreen<ZooShort, Zoo> {
  const ZooScreen({Key? key, required ZooShort zoo})
      : super(key: key, attraction: zoo);

  @override
  Future<Zoo> readFull() {
    return Zoo.readZoo(attraction.id);
  }
}
