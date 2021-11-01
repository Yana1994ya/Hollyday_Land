import 'package:flutter/material.dart';
import 'package:hollyday_land/models/attraction.dart';

class AttractionCard extends StatefulWidget {
  static const double BORDER_RADIUS = 10.0;
  final Attraction attraction;

  const AttractionCard({Key? key, required this.attraction}) : super(key: key);

  @override
  State<AttractionCard> createState() => _AttractionCardState();
}

class _AttractionCardState extends State<AttractionCard> {
  int imageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final Image image;
    if (imageIndex == 0) {
      image = widget.attraction.image == null
          ? Image.asset("assets/graphics/icon.png")
          : Image.network(
              widget.attraction.image!.url,
              fit: BoxFit.cover,
            );
    } else {
      image = Image.network(
        widget.attraction.additionalImages[imageIndex - 1].url,
        fit: BoxFit.cover,
      );
    }

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AttractionCard.BORDER_RADIUS),
      ),
      child: Container(
        height: 280,
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  imageIndex += 1;
                  if (imageIndex ==
                      widget.attraction.additionalImages.length + 1) {
                    imageIndex = 0;
                  }
                });
              },
              child: Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: image.image,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(AttractionCard.BORDER_RADIUS),
                    topRight: Radius.circular(AttractionCard.BORDER_RADIUS),
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
            ),
            // Title
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 15,
              ),
              width: double.infinity,
              child: Text(
                widget.attraction.name,
                textAlign: TextAlign.left,
              ),
            )
          ],
        ),
      ),
    );
  }
}
