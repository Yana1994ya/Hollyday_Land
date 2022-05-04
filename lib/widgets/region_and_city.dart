import "package:flutter/material.dart";

class RegionAndCity extends StatelessWidget {
  final String region;
  final String? city;

  const RegionAndCity({Key? key, required this.region, required this.city})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          region,
        ),
        if (city != null) Icon(Icons.arrow_right_rounded, size: 16.0),
        if (city != null) Text(city!),
      ],
    );
  }
}
