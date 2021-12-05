import "package:flutter/material.dart";
import "package:hollyday_land/models/base_attraction.dart";
import "package:hollyday_land/models/zoo/zoo.dart";
import "package:hollyday_land/screens/attraction.dart";

class ZooScreen extends AttractionScreen<Zoo> {
  const ZooScreen({Key? key, required BaseAttraction attraction})
      : super(key: key, attraction: attraction);

  @override
  Future<Zoo> readFull() {
    return Zoo.readZoo(attraction.id);
  }
}
