import '../attraction_filter.dart';

class WineryFilter extends AttractionFilter {
  @override
  final Set<int> regionIds;

  const WineryFilter({required this.regionIds});

  factory WineryFilter.empty() {
    return WineryFilter(regionIds: {});
  }
}
