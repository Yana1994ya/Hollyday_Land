import "package:flutter/material.dart";
import "package:hollyday_land/models/museum/museum_short.dart";
import "package:hollyday_land/screens/museum/museum.dart";

class MuseumListItem extends StatelessWidget {
  static const double borderRadius = 10.0;
  final MuseumShort museum;

  const MuseumListItem({Key? key, required this.museum}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Image image;
    image = museum.mainImage == null
        ? Image.asset(
            "assets/graphics/icon.png",
            fit: BoxFit.cover,
          )
        : Image.network(
            museum.mainImage!.url,
            fit: BoxFit.cover,
          );

    return InkWell(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(MuseumListItem.borderRadius),
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
                    topLeft: Radius.circular(MuseumListItem.borderRadius + 3),
                    topRight: Radius.circular(MuseumListItem.borderRadius + 3),
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
                child: Column(children: [
                  Align(
                    child: Text(
                      museum.name,
                    ),
                    alignment: Alignment.topLeft,
                  ),
                  Row(
                    children: [
                      Text(
                        museum.region.name,
                      ),
                      Container(
                        width: 8.0,
                      ),
                      Expanded(
                        child: ClipRect(
                          child: Text(museum.address),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    child: Text(museum.domain.name),
                    alignment: Alignment.topLeft,
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => MuseumScreen(museum: museum)));
      },
    );
  }
}
