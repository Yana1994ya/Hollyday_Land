import "package:flutter/material.dart";
import "package:hollyday_land/models/trail/difficulty.dart";
import "package:hollyday_land/models/trail/short.dart";
import "package:hollyday_land/screens/trail/trail.dart";
import "package:hollyday_land/widgets/distance.dart";
import "package:hollyday_land/widgets/rating.dart";

class TrailListItem extends StatelessWidget {
  static const double borderRadius = 10.0;
  final TrailShort trail;

  const TrailListItem({Key? key, required this.trail}) : super(key: key);

  MaterialPageRoute get pageRoute {
    return MaterialPageRoute(
      builder: (_) => TrailScreen(
        trail: trail,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Image image;
    image = trail.mainImage == null
        ? Image.asset(
            "assets/graphics/icon.png",
            fit: BoxFit.cover,
          )
        : Image.network(
            trail.mainImage!.url,
            fit: BoxFit.cover,
          );

    return InkWell(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(TrailListItem.borderRadius),
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
                    topLeft: Radius.circular(TrailListItem.borderRadius + 3),
                    topRight: Radius.circular(TrailListItem.borderRadius + 3),
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
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
                child: Column(children: <Widget>[
                  Align(
                    child: Text(
                      trail.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                      softWrap: false,
                    ),
                    alignment: Alignment.topLeft,
                  ),
                  Align(
                    child: Text(
                      "Difficulty: " +
                          difficultyToDescription(trail.difficulty) +
                          " ,distance: " +
                          (trail.length.toDouble() / 1000.0)
                              .toStringAsFixed(2) +
                          "km" +
                          " ,elv gain: " +
                          trail.elevationGain.toString() +
                          "m",
                    ),
                    alignment: Alignment.topLeft,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Rating(rating: trail),
                      Distance(location: trail),
                    ],
                  ),
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
