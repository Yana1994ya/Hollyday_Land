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
}
