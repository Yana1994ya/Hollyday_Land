import "package:hollyday_land/api_server.dart";
import "package:hollyday_land/models/tour/short.dart";
import "package:intl/intl.dart";

class Reservation {
  final int id;
  final TourShort tour;
  final DateTime day;
  final String name;
  final String phoneNumber;

  Reservation({
    required this.id,
    required this.tour,
    required this.day,
    required this.name,
    required this.phoneNumber,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      id: json["id"],
      tour: TourShort.fromJson(json["tour"]),
      day: DateFormat("yyyy/MM/dd").parse(json["day"]),
      name: json["name"],
      phoneNumber: json["phone_number"],
    );
  }

  static Future<List<Reservation>> readReservations(String token) {
    return ApiServer.post(
      "attractions/api/tours/reservations",
      "reservations",
      {"token": token},
    ).then((value) => (value as List<dynamic>)
        .map(
          (elem) => Reservation.fromJson(elem),
        )
        .toList());
  }
}
