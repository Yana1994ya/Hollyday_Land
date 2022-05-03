import "package:hollyday_land/models/offroad/trip_type.dart";
import "package:hollyday_land/models/region.dart";

class OffRoadTripFilterOptions {
  final List<OffRoadTripType> tripTypes;
  final List<Region> regions;

  const OffRoadTripFilterOptions({
    required this.tripTypes,
    required this.regions,
  });

  static Future<OffRoadTripFilterOptions> fetch() async {
    final tripTypes = await offRoadTripTypeObjects.readTags();
    final regions = await regionObjects.readTags();

    return OffRoadTripFilterOptions(tripTypes: tripTypes, regions: regions);
  }
}
