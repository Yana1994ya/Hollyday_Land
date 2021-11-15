class MuseumFilter {
  final Set<int> regionIds;
  final Set<int> domainIds;

  const MuseumFilter({required this.regionIds, required this.domainIds});

  factory MuseumFilter.empty() {
    return MuseumFilter(regionIds: {}, domainIds: {});
  }
}
