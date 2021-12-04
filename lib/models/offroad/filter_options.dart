import "package:hollyday_land/models/offroad/trip_type.dart";
import "package:hollyday_land/models/region.dart";

class OffRoadTripFilterOptions {
  final List<TripType> tripTypes;
  final List<Region> regions;

  const OffRoadTripFilterOptions({
    required this.tripTypes,
    required this.regions,
  });

  static Future<OffRoadTripFilterOptions> fetch() async {
    final tripTypes = await TripType.readTripTypes();
    final regions = await Region.readRegions();

    return OffRoadTripFilterOptions(tripTypes: tripTypes, regions: regions);
  }
}
