import "package:flutter/material.dart";
import "package:hollyday_land/models/tour/reservation.dart";
import "package:hollyday_land/providers/login.dart";
import "package:hollyday_land/screens/profile.dart";
import "package:hollyday_land/widgets/no_results.dart";
import "package:intl/intl.dart";
import "package:provider/provider.dart";

class ReservationsScreen extends StatelessWidget {
  static const routePath = "/reservations";

  @override
  Widget build(BuildContext context) {
    final LoginProvider loginProvider = Provider.of<LoginProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Reservations"),
      ),
      body: loginProvider.currentUser == null
          ? ProfileScreen.loginBody(context, loginProvider)
          : _LoggedInReservationScreen(token: loginProvider.hdToken!),
    );
  }
}

class _LoggedInReservationScreen extends StatelessWidget {
  final String token;

  const _LoggedInReservationScreen({Key? key, required this.token})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Reservation>>(
        future: Reservation.readReservations(token),
        builder: (_, AsyncSnapshot<List<Reservation>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("error: ${snapshot.error}"),
            );
          } else if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            final data = snapshot.data!;

            if (data.isEmpty) {
              return NoResults(text: "No reservations yet");
            }

            return ListView.separated(
              itemCount: data.length,
              itemBuilder: (_, index) {
                return ListTile(
                  title: Text(data[index].tour.name),
                  subtitle: Text(
                    DateFormat.yMMMd().format(data[index].day) +
                        " ,reservation #" +
                        data[index].id.toString(),
                  ),
                  trailing: Column(
                    children: [
                      Text(data[index].price.toStringAsFixed(2) + "\$"),
                      Text(data[index].group ? "/ group" : "/ person")
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
            );
          }
        });
  }
}
