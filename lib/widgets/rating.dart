import "package:flutter/material.dart";

class Rating extends StatelessWidget {
  final double rating;
  final int count;

  const Rating({Key? key, required this.rating, required this.count})
      : super(key: key);

  IconData iconFor(double number) {
    if (rating >= number) {
      return Icons.star;
    } else if (rating < number && rating >= number - 1) {
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
          iconFor(1),
          size: 16.0,
          color: Colors.amber,
        ),
        Icon(
          iconFor(2),
          size: 16.0,
          color: Colors.amber,
        ),
        Icon(
          iconFor(3),
          size: 16.0,
          color: Colors.amber,
        ),
        Icon(
          iconFor(4),
          size: 16.0,
          color: Colors.amber,
        ),
        // Icon(Icons.star_outlined, size: 16.0),
        Icon(
          iconFor(5),
          size: 16.0,
          color: Colors.amber,
        ),
        Text(count.toString())
      ],
    );
  }
}
