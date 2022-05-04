import "package:built_collection/built_collection.dart";
import "package:hollyday_land/models/filter/attraction_filter.dart";

class TourFilter extends AttractionFilter {
  final BuiltSet<int> overnightIds;
  final BuiltSet<int> packageIds;
  final BuiltSet<int> startLocationIds;
  final BuiltSet<int> tourDestinationIds;
  final BuiltSet<int> tourLanguageIds;
  final BuiltSet<int> tourThemeIds;
  final BuiltSet<int> tourTypeIds;

  const TourFilter({
    required this.overnightIds,
    required this.packageIds,
    required this.startLocationIds,
    required this.tourDestinationIds,
    required this.tourLanguageIds,
    required this.tourThemeIds,
    required this.tourTypeIds,
  });

  factory TourFilter.create({
    BuiltSet<int>? overnightIds,
    BuiltSet<int>? packageIds,
    BuiltSet<int>? startLocationIds,
    BuiltSet<int>? tourDestinationIds,
    BuiltSet<int>? tourLanguageIds,
    BuiltSet<int>? tourThemeIds,
    BuiltSet<int>? tourTypeIds,
  }) {
    BuiltSet<int> empty = BuiltSet.of([]);

    return TourFilter(
      overnightIds: overnightIds ?? empty,
      packageIds: packageIds ?? empty,
      startLocationIds: startLocationIds ?? empty,
      tourDestinationIds: tourDestinationIds ?? empty,
      tourLanguageIds: tourLanguageIds ?? empty,
      tourThemeIds: tourThemeIds ?? empty,
      tourTypeIds: tourTypeIds ?? empty,
    );
  }

  static void optionalParams(
      Map<String, Iterable<String>> params, String key, BuiltSet<int> ids) {
    if (ids.isNotEmpty) {
      params[key] = ids.map((id) => id.toString());
    }
  }

  @override
  Map<String, Iterable<String>> get parameters {
    Map<String, Iterable<String>> params = {};

    optionalParams(params, "overnight_id", overnightIds);
    optionalParams(params, "package_id", packageIds);
    optionalParams(params, "start_location_id", startLocationIds);
    optionalParams(params, "tour_destination_id", tourDestinationIds);
    optionalParams(params, "tour_language_id", tourLanguageIds);
    optionalParams(params, "tour_theme_id", tourThemeIds);
    optionalParams(params, "tour_type_id", tourTypeIds);

    return params;
  }
}
