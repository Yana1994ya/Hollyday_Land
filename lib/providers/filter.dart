import "package:flutter/material.dart";
import "package:hollyday_land/models/filter/attraction_filter.dart";

abstract class FilterProvider with ChangeNotifier {
  AttractionFilter get currentState;
}
