import "package:flutter/material.dart";
import "package:hollyday_land/models/attraction_short.dart";

abstract class AttractionListItem<T extends AttractionShort>
    extends StatelessWidget {
  static const double borderRadius = 10.0;
  final T attraction;

  const AttractionListItem({Key? key, required this.attraction})
      : super(key: key);

  MaterialPageRoute get pageRoute;

  List<Widget> extraInformation(BuildContext context);

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
                        ] +
                        extraInformation(context)),
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
