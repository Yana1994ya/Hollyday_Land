import '../region.dart';
import 'museum_domain.dart';

class MuseumFilter {
  final Region? region;
  final MuseumDomain? domain;

  const MuseumFilter({ required this.region, required this.domain });

  factory MuseumFilter.empty() {
    return MuseumFilter(region: null, domain: null);
  }
}
