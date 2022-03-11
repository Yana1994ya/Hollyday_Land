import "package:hollyday_land/models/location.dart";
import "package:hollyday_land/models/rating.dart";

abstract class BaseAttraction with WithLocation, WithRating {
  int get id;

  String get name;
}
