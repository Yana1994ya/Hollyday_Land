import "package:built_collection/built_collection.dart";
import "package:copy_with_extension/copy_with_extension.dart";
import "package:hollyday_land/models/filter/attraction_filter.dart";

part "filter.g.dart";

@CopyWith()
class ExtremeSportsFilter extends AttractionFilter {
  final BuiltSet<int> regionIds;
  final BuiltSet<int> typeIds;

  const ExtremeSportsFilter({
    required this.regionIds,
    required this.typeIds,
  });

  factory ExtremeSportsFilter.empty() {
    return ExtremeSportsFilter(
      regionIds: BuiltSet.of([]),
      typeIds: BuiltSet.of([]),
    );
  }

  @override
  Map<String, Iterable<String>> get parameters {
    final Map<String, Iterable<String>> params = {};

    if (regionIds.isNotEmpty) {
      params["region_id"] = regionIds.map((id) => id.toString());
    }

    if (typeIds.isNotEmpty) {
      params["type_id"] = typeIds.map((id) => id.toString());
    }

    return params;
  }
}
