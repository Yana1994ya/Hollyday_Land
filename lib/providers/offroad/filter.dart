import "package:hollyday_land/models/filter/attraction_filter.dart";
import "package:hollyday_land/models/offroad/filter.dart";
import "package:hollyday_land/models/offroad/trip_type.dart";
import "package:hollyday_land/providers/filter.dart";
import "package:hollyday_land/providers/region_ids.dart";

class OffRoadTripFilterProvider extends FilterProvider with RegionIds {
  @override
  final Set<int> regionIds;
  final Set<int> tripTypeIds;

  OffRoadTripFilterProvider(this.regionIds, this.tripTypeIds);

  toggleTripType(TripType tripType) {
    if (tripTypeIds.contains(tripType.id)) {
      tripTypeIds.remove(tripType.id);
    } else {
      tripTypeIds.add(tripType.id);
    }
    notifyListeners();
  }

  bool tripTypeIsSelected(TripType domain) {
    return tripTypeIds.contains(domain.id);
  }

  @override
  AttractionFilter get currentState => OffRoadTripFilter(
        regionIds: regionIds,
        tripTypeIds: tripTypeIds,
      );
}
