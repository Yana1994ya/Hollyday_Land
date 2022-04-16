import "package:flutter/material.dart";
import "package:hollyday_land/models/dao/base_attraction.dart";
import "package:hollyday_land/models/dao/base_attraction_short.dart";
import "package:hollyday_land/screens/attraction.dart";
import "package:hollyday_land/widgets/attraction_map.dart";
import "package:hollyday_land/widgets/description.dart";
import 'package:hollyday_land/widgets/managed_list_item.dart';
import "package:url_launcher/url_launcher.dart";

abstract class ManagedAttractionScreen<T extends ManagedAttraction>
    extends AttractionScreen<T> {
  const ManagedAttractionScreen({Key? key, required AttractionShort attraction})
      : super(key: key, attraction: attraction);

  static void launchUrl(String url) async =>
      await canLaunch(url) ? await launch(url) : throw "Could not launch $url";

  static void launchPhone(String number) => launchUrl("tel:" + number);

  List<Widget> extraInformation(final T attraction, BuildContext context) {
    return [];
  }

  @override
  List<Widget> pageBody(final T attraction, BuildContext context) {
    return [
      SizedBox(height: 5),
      Align(
        child: ManagedAttractionListItem.locationWidget(
          attraction.region.name,
          attraction.city,
        ),
        alignment: Alignment.topLeft,
      ),
      ...extraInformation(attraction, context),
      if (attraction.website != null || attraction.telephone != null)
        Row(
          children: [
            if (attraction.website != null)
              TextButton(
                onPressed: () {
                  launchUrl(attraction.website!);
                },
                child: Row(
                  children: [
                    //Icon(Icons.iron),
                    Text("Visit website")
                  ],
                ),
              ),
            if (attraction.telephone != null)
              TextButton(
                onPressed: () {
                  launchPhone(attraction.telephone!);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.phone,
                      size: 16.0,
                    ),
                    Text("call")
                  ],
                ),
              ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
      if (attraction.description.isNotEmpty)
        Description(text: attraction.description),
      SizedBox(
        width: double.infinity,
        height: 300.0,
        child: AttractionMap(
          attraction: attraction,
        ),
      )
    ];
  }

  @override
  List<Widget> extraActionButtons(final T attraction, BuildContext context) {
    return [];
  }
}
