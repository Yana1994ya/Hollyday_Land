import "package:hollyday_land/models/dao/base_attraction.dart";
import "package:hollyday_land/models/dao/model_access.dart";
import "package:hollyday_land/models/offroad/trip_type.dart";
import "package:hollyday_land_dao/full_dao.dart";

part "offroad.objects.full.dart";

@FullDao("offroad")
class OffRoadTrip extends ManagedAttraction {
  final OffRoadTripType tripType;

  OffRoadTrip({
    required BaseAttraction base,
    required this.tripType,
  }) : super(base);

  factory OffRoadTrip.fromJson(Map<String, dynamic> json) {
    return OffRoadTrip(
      base: BaseAttraction.fromJson(json),
      tripType: OffRoadTripType.fromJson(json["trip_type"]),
    );
  }

  @override
  String toString() => genString("Offroad", "tripType: $tripType");
}
