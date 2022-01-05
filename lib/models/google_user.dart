class GoogleUser {
  final String id;
  final String name;
  final String? picture;

  GoogleUser({
    required this.id,
    required this.name,
    required this.picture,
  });

  factory GoogleUser.fromJson(Map<String, dynamic> json) {
    return GoogleUser(
        id: json["id"], name: json["name"], picture: json["picture"]);
  }
}
