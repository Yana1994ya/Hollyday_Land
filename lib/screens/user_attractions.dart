import "package:flutter/material.dart";
import "package:hollyday_land/models/dao/base_attraction_short.dart";
import "package:hollyday_land/providers/login.dart";
import "package:hollyday_land/screens/profile.dart";
import "package:hollyday_land/widgets/list_item.dart";
import "package:hollyday_land/widgets/no_results.dart";
import "package:provider/provider.dart";

abstract class UserAttractionsScreen<Attraction extends AttractionShort>
    extends StatelessWidget {
  String itemCountText(List<Attraction> attractions);

  Future<List<Attraction>> readAttractions(
    String hdToken,
    BuildContext context,
  );

  AttractionListItem<Attraction> getListItem(Attraction attraction);

  String get pageTitle;

  Widget itemCount(BuildContext context, List<Attraction> attractions) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 3,
        horizontal: 8,
      ),
      child: Text(itemCountText(attractions)),
    );
  }

  Widget bodyWidget(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);

    if (loginProvider.currentUser == null) {
      return ProfileScreen.loginBody(context, loginProvider);
    } else {
      return FutureBuilder<List<Attraction>>(
          future: readAttractions(loginProvider.hdToken!, context),
          builder: (_, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text("error ${snapshot.error}"));
            } else if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              List<Attraction> attractions = snapshot.data!;

              if (attractions.isEmpty) {
                return const NoResults(text: "No attractions to display");
              } else {
                return ListView.builder(
                  itemBuilder: (_, index) => index == 0
                      ? itemCount(context, attractions)
                      : getListItem(attractions[index - 1]),
                  itemCount: attractions.length + 1,
                );
              }
            }
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
      ),
      body: bodyWidget(context),
    );
  }
}
