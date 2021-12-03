import "package:hollyday_land/models/filter/attraction_filter.dart";
import "package:hollyday_land/models/museum/filter.dart";
import "package:hollyday_land/models/museum/museum_domain.dart";
import "package:hollyday_land/providers/filter.dart";
import "package:hollyday_land/providers/region_ids.dart";

class MuseumFilterProvider extends FilterProvider with RegionIds {
  @override
  final Set<int> regionIds;
  final Set<int> domainIds;

  MuseumFilterProvider(this.regionIds, this.domainIds);

  toggleDomain(MuseumDomain domain) {
    if (domainIds.contains(domain.id)) {
      domainIds.remove(domain.id);
    } else {
      domainIds.add(domain.id);
    }
    notifyListeners();
  }

  bool domainIsSelected(MuseumDomain domain) {
    return domainIds.contains(domain.id);
  }

  @override
  AttractionFilter get currentState => MuseumFilter(
        regionIds: regionIds,
        domainIds: domainIds,
      );
}
