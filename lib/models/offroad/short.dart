import "package:hollyday_land/models/dao/base_attraction_short.dart";
import "package:hollyday_land/models/dao/model_access.dart";
import "package:hollyday_land/models/offroad/trip_type.dart";
import "package:hollyday_land_dao/list_dao.dart";

part "short.objects.list.dart";

@ListDao("offroad")
class OffRoadTripShort extends ManagedAttractionShort {
  final OffRoadTripType tripType;

  const OffRoadTripShort({
    required BaseAttractionShort base,
    required this.tripType,
  }) : super(base);

  factory OffRoadTripShort.fromJson(Map<String, dynamic> json) {
    return OffRoadTripShort(
      base: BaseAttractionShort.fromJson(json),
      tripType: OffRoadTripType.fromJson(json["trip_type"]),
    );
  }

  @override
  String toString() {
    return genString("MuseumShort", "tripType: $tripType");
  }
}
