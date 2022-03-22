import "package:decimal/decimal.dart";
import "package:flutter/material.dart";
import "package:hollyday_land/models/rating.dart";

class Rating extends StatelessWidget {
  final WithRating rating;

  const Rating({
    Key? key,
    required this.rating,
  }) : super(key: key);

  IconData iconFor(Decimal number) {
    if (rating.avgRating >= number) {
      return Icons.star;
    } else if (rating.avgRating < number &&
        rating.avgRating > number - Decimal.one) {
      return Icons.star_half;
    } else {
      return Icons.star_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          iconFor(Decimal.one),
          size: 16.0,
          color: Colors.amber,
        ),
        Icon(
          iconFor(Decimal.fromInt(2)),
          size: 16.0,
          color: Colors.amber,
        ),
        Icon(
          iconFor(Decimal.fromInt(3)),
          size: 16.0,
          color: Colors.amber,
        ),
        Icon(
          iconFor(Decimal.fromInt(4)),
          size: 16.0,
          color: Colors.amber,
        ),
        // Icon(Icons.star_outlined, size: 16.0),
        Icon(
          iconFor(Decimal.fromInt(5)),
          size: 16.0,
          color: Colors.amber,
        ),
        Text(rating.avgRating.toString()),
        if (rating.ratingCount > 0) Text(" (${rating.ratingCount})")
      ],
    );
  }
}
