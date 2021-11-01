import 'package:flutter/material.dart';
import 'package:hollyday_land/models/attraction.dart';

class AttractionCard extends StatelessWidget {
  static const double BORDER_RADIUS = 10.0;
  final Attraction attraction;

  const AttractionCard({Key? key, required this.attraction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final image = attraction.image == null
        ? Image.asset("assets/graphics/icon.png")
        : Image.network(
            attraction.image!,
            fit: BoxFit.cover,
          );

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(BORDER_RADIUS),
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
                  topLeft: Radius.circular(BORDER_RADIUS),
                  topRight: Radius.circular(BORDER_RADIUS),
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
              width: double.infinity,
              child: Text(
                attraction.name,
                textAlign: TextAlign.left,
              ),
            )
          ],
        ),
      ),
    );
  }
}
