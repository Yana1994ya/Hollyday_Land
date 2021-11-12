import 'package:flutter/material.dart';
import 'package:hollyday_land/models/museum/museum_short.dart';
import 'package:hollyday_land/providers/login.dart';
import 'package:hollyday_land/widgets/museum/list_item.dart';
import 'package:provider/provider.dart';

class HistoryMuseumsScreen extends StatelessWidget {
  static const routePath = "/history/museums";

  Widget pageTitle(BuildContext context, List<MuseumShort> museums) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 3,
        horizontal: 8,
      ),
      child: Text("found ${museums.length} museums"),
    );
  }

  Widget bodyWidget(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);

    if (loginProvider.currentUser == null) {
      return Center(
        child: Text("please login to view history"),
      );
    } else {
      return FutureBuilder(
          future: MuseumShort.readHistory(loginProvider.hdToken!),
          builder: (_, AsyncSnapshot<List<MuseumShort>> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text("error ${snapshot.error}"));
            } else if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              List<MuseumShort> museums = snapshot.data!;

              return ListView.builder(
                itemBuilder: (_, index) => index == 0
                    ? pageTitle(context, museums)
                    : MuseumListItem(museum: museums[index - 1]),
                itemCount: museums.length + 1,
              );
            }
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Visited museums"),
      ),
      body: bodyWidget(context),
    );
  }
}
