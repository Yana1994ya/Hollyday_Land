import "package:built_collection/built_collection.dart";
import "package:copy_with_extension/copy_with_extension.dart";
import "package:hollyday_land/models/filter/attraction_filter.dart";

part "filter.g.dart";

@CopyWith()
class TourFilter extends AttractionFilter {
  final BuiltSet<int> packageIds;
  final BuiltSet<int> destinationIds;
  final BuiltSet<int> tourLanguageIds;
  final BuiltSet<int> tourTypeIds;

  const TourFilter({
    required this.packageIds,
    required this.destinationIds,
    required this.tourLanguageIds,
    required this.tourTypeIds,
  });

  factory TourFilter.create({
    BuiltSet<int>? packageIds,
    BuiltSet<int>? destinationIds,
    BuiltSet<int>? tourLanguageIds,
    BuiltSet<int>? tourTypeIds,
  }) {
    BuiltSet<int> empty = BuiltSet.of([]);

    return TourFilter(
      packageIds: packageIds ?? empty,
      destinationIds: destinationIds ?? empty,
      tourLanguageIds: tourLanguageIds ?? empty,
      tourTypeIds: tourTypeIds ?? empty,
    );
  }

  static void optionalParams(Map<String, Iterable<String>> params, String key, BuiltSet<int> ids) {
    if (ids.isNotEmpty) {
      params[key] = ids.map((id) => id.toString());
    }
  }

  @override
  Map<String, Iterable<String>> get parameters {
    Map<String, Iterable<String>> params = {};

    optionalParams(params, "package_id", packageIds);
    optionalParams(params, "destination_id", destinationIds);
    optionalParams(params, "language_id", tourLanguageIds);
    optionalParams(params, "tour_type_id", tourTypeIds);

    return params;
  }
}
