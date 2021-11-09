import '../../config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MuseumDomain {
  final int id;
  final String name;

  MuseumDomain({required this.id, required this.name});

  factory MuseumDomain.fromJson(Map<String, dynamic> json) {
    return MuseumDomain(
      id: json['id'],
      name: json['name'],
    );
  }

  @override
  String toString() {
    return 'MuseumDomain{id: $id, name: $name}';
  }

  static Future<List<MuseumDomain>> readMuseumDomains() async {
    final uri = Uri.https(
      API_SERVER,
      "/attractions/api/museum_domains",
    );

    print("fetching: $uri");

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      if (data["status"] == "ok") {
        final List<dynamic> domains = data["domains"];
        return domains.map((e) => MuseumDomain.fromJson(e)).toList();
      } else {
        throw Exception("error was returned:${data["error"]}");
      }
    } else {
      throw Exception("failed to load data, status: ${response.statusCode}");
    }
  }
}
