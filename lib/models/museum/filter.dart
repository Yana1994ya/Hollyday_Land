import "package:hollyday_land/models/attraction_filter.dart";

class MuseumFilter extends AttractionFilter {
  @override
  final Set<int> regionIds;
  final Set<int> domainIds;

  const MuseumFilter({required this.regionIds, required this.domainIds});

  factory MuseumFilter.empty() {
    return MuseumFilter(regionIds: {}, domainIds: {});
  }
}
