import "package:hollyday_land/models/museum/filter.dart";
import "package:hollyday_land/models/museum/museum_domain.dart";
import "package:hollyday_land/providers/attraction_filter.dart";

class MuseumFilterProvider extends AttractionFilterProvider<MuseumFilter> {
  final Set<int> _domainIds;

  factory MuseumFilterProvider.fromFilter(MuseumFilter filter) {
    return MuseumFilterProvider(
      regionIds: filter.regionIds,
      domainIds: filter.domainIds,
    );
  }

  MuseumFilterProvider({required Set<int> regionIds, required Set<int> domainIds})
      : _domainIds = domainIds,
        super(regionIds: regionIds);

  toggleDomain(MuseumDomain domain) {
    if (_domainIds.contains(domain.id)) {
      _domainIds.remove(domain.id);
    } else {
      _domainIds.add(domain.id);
    }
    notifyListeners();
  }

  bool domainSelected(MuseumDomain domain) {
    return _domainIds.contains(domain.id);
  }

  @override
  MuseumFilter get filter {
    return MuseumFilter(
      regionIds: regionIds,
      domainIds: _domainIds,
    );
  }
}
