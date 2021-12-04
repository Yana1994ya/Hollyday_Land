import "package:hollyday_land/models/location.dart";

abstract class BaseAttraction with WithLocation {
  int get id;

  String get name;
}
