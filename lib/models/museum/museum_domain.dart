import "package:hollyday_land/api_server.dart";
import "package:hollyday_land/models/filter_tag.dart";

class MuseumDomain with FilterTag {
  @override
  final int id;
  @override
  final String name;

  const MuseumDomain({required this.id, required this.name});

  factory MuseumDomain.fromJson(Map<String, dynamic> json) {
    return MuseumDomain(
      id: json["id"],
      name: json["name"],
    );
  }

  @override
  String toString() {
    return "MuseumDomain{id: $id, name: $name}";
  }

  static List<MuseumDomain> _mapDomains(dynamic apiResult) {
    return (apiResult as List<dynamic>)
        .map((domain) => MuseumDomain.fromJson(domain))
        .toList();
  }

  static Future<List<MuseumDomain>> readMuseumDomains() async {
    return ApiServer.get(
      "/attractions/api/museum_domains",
      "museum_domains",
    ).then(_mapDomains);
  }
}
