import "dart:math";

import "package:flutter/material.dart";
import "package:hollyday_land/models/attraction_short.dart";
import "package:hollyday_land/providers/location_provider.dart";
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import "package:provider/provider.dart";

abstract class AttractionListItem<T extends AttractionShort>
    extends StatelessWidget {
  static final DISTANCE_FORMAT = NumberFormat("###.0#", "en_US");
  static const double borderRadius = 10.0;
  final T attraction;

  const AttractionListItem({Key? key, required this.attraction})
      : super(key: key);

  MaterialPageRoute get pageRoute;

  List<Widget> extraInformation(BuildContext context);

  double _calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;

    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  Widget distanceWidget(LocationData locationData) {
    final double distance = _calculateDistance(locationData.latitude,
        locationData.longitude, attraction.lat, attraction.long);

    return Text(DISTANCE_FORMAT.format(distance) + " km");
  }

  @override
  Widget build(BuildContext context) {
    final Image image;
    image = attraction.mainImage == null
        ? Image.asset(
            "assets/graphics/icon.png",
            fit: BoxFit.cover,
          )
        : Image.network(
            attraction.mainImage!.url,
            fit: BoxFit.cover,
          );

    LocationProvider location = Provider.of<LocationProvider>(context);

    return InkWell(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AttractionListItem.borderRadius),
        ),
        child: Container(
          height: 280,
          child: Column(
            children: [
              Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: image.image,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft:
                    Radius.circular(AttractionListItem.borderRadius + 3),
                    topRight:
                    Radius.circular(AttractionListItem.borderRadius + 3),
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        //Colors.grey.shade400.withOpacity(0.9),
                        //Colors.grey.shade400.withOpacity(0)
                        Colors.black.withOpacity(0.4),
                        Colors.white.withOpacity(0),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              // Title
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
                child: Column(
                    children: <Widget>[
                      Align(
                        child: Text(
                          attraction.name,
                        ),
                        alignment: Alignment.topLeft,
                      ),
                      Row(
                        children: [
                          Text(
                            attraction.region.name,
                          ),
                      Container(
                        width: 8.0,
                      ),
                      Expanded(
                        child: ClipRect(
                          child: Text(attraction.address),
                        ),
                      ),
                    ],
                  ),
                  ...extraInformation(context),
                  if (location.lastSnapshot != null &&
                      location.lastSnapshot!.status == LocationStatus.recieved)
                    distanceWidget(location.lastSnapshot!.location!)
                ]),
              )
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.of(context).push(pageRoute);
      },
    );
  }
}
