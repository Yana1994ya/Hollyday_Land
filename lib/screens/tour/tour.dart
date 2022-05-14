import "package:flutter/material.dart";
import "package:hollyday_land/models/tour/short.dart";
import "package:hollyday_land/models/tour/tour.dart";
import "package:hollyday_land/providers/cache_key.dart";
import "package:hollyday_land/screens/attraction_reviews.dart";
import "package:hollyday_land/screens/tour/order.dart";
import "package:hollyday_land/widgets/description.dart";
import "package:hollyday_land/widgets/image_carousel.dart";
import "package:hollyday_land/widgets/rating.dart";
import "package:hollyday_land/widgets/tour/calendar.dart";
import "package:provider/provider.dart";

class TourScreen extends StatelessWidget {
  final TourShort short;

  const TourScreen({Key? key, required this.short}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int cacheKey = Provider.of<CacheKey>(context).cacheKey;

    return Scaffold(
      appBar: AppBar(
        title: Text(short.name),
      ),
      body: FutureBuilder(
        future: tourObjects.read(short.id, cacheKey),
        builder: (_, AsyncSnapshot<Tour> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("error: ${snapshot.error}"),
            );
          } else if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            final Tour tour = snapshot.data!;

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ImageCarousel(
                      images: ImageCarousel.collectImages(
                        tour.mainImage,
                        tour.additionalImages,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: Text(
                          tour.name,
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        children: [
                          GestureDetector(
                            child: Rating(rating: tour),
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (_ctx) {
                                return AttractionReviewsScreen(
                                  attractionId: tour.id,
                                );
                              }));
                            },
                          ),
                          Column(
                            children: [
                              Text(
                                tour.price.toStringAsFixed(2) + "\$",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              Text(tour.group ? "/group" : "/person")
                            ],
                          )
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      ),
                    ),
                    if (tour.description.isNotEmpty)
                      Description(text: tour.description),
                    TourCalendar(
                      tourId: tour.id,
                      onOrder: (date) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (_) =>
                                  TourOrder(tour: tour, date: date)),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
