import '../region.dart';
import 'museum_domain.dart';

class MuseumFilter {
  final Set<int> regions;
  final Set<int> domains;

  const MuseumFilter({ required this.regions, required this.domains });

  factory MuseumFilter.empty() {
    return MuseumFilter(regions: Set(), domains: Set());
  }
}
