import "package:flutter/material.dart";
import "package:hollyday_land/models/tour/short.dart";
import "package:hollyday_land/screens/tour/tour.dart";
import "package:hollyday_land/widgets/list_item.dart";
import "package:hollyday_land/widgets/rating.dart";

class TourListItem extends AttractionListItem<TourShort> {
  const TourListItem({Key? key, required TourShort attraction})
      : super(key: key, attraction: attraction);

  @override
  Widget ratingRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Rating(rating: attraction),
        Column(
          children: [
            Text(
              attraction.price.toStringAsFixed(2) + "\$",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            Text(attraction.group ? "/group" : "/person")
          ],
        )
      ],
    );
  }

  @override
  List<Widget> extraInformation(BuildContext context) {
    return [];
  }

  @override
  MaterialPageRoute get pageRoute =>
      MaterialPageRoute(builder: (_) => TourScreen(short: attraction));
}
