import "package:hollyday_land/models/museum/museum_domain.dart";
import "package:hollyday_land/models/region.dart";

class MuseumFilterOptions {
  final List<MuseumDomain> domains;
  final List<Region> regions;

  const MuseumFilterOptions({
    required this.domains,
    required this.regions,
  });

  static Future<MuseumFilterOptions> fetch() async {
    final domains = await museumDomainObjects.readTags();
    final regions = await regionObjects.readTags();

    return MuseumFilterOptions(domains: domains, regions: regions);
  }
}
