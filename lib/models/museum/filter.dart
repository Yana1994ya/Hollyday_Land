import "package:built_collection/built_collection.dart";
import "package:copy_with_extension/copy_with_extension.dart";
import "package:hollyday_land/models/filter/attraction_filter.dart";

part "filter.g.dart";

@CopyWith()
class MuseumFilter extends AttractionFilter {
  final BuiltSet<int> regionIds;
  final BuiltSet<int> domainIds;

  const MuseumFilter({required this.regionIds, required this.domainIds});

  factory MuseumFilter.empty() {
    return MuseumFilter(regionIds: BuiltSet.of([]), domainIds: BuiltSet.of([]));
  }

  @override
  Map<String, Iterable<String>> get parameters {
    final Map<String, Iterable<String>> params = {};

    if (regionIds.isNotEmpty) {
      params["region_id"] = regionIds.map((id) => id.toString());
    }

    if (domainIds.isNotEmpty) {
      params["domain_id"] = domainIds.map((id) => id.toString());
    }

    return params;
  }
}
