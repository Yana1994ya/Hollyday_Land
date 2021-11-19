import "package:hollyday_land/models/attraction_filter_options.dart";
import "package:hollyday_land/models/museum/museum_domain.dart";
import "package:hollyday_land/models/region.dart";

class MuseumFilterOptions extends AttractionFilterOptions {
  final List<MuseumDomain> domains;
  @override
  final List<Region> regions;

  const MuseumFilterOptions({
    required this.domains,
    required this.regions,
  });

  static Future<MuseumFilterOptions> fetch() async {
    final domains = await MuseumDomain.readMuseumDomains();
    final regions = await Region.readRegions();

    return MuseumFilterOptions(domains: domains, regions: regions);
  }
}
