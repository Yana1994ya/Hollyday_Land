import "package:flutter/material.dart";

class NoResults extends StatelessWidget {
  final String text;
  final String? subTitle;

  const NoResults({Key? key, required this.text, this.subTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Image(
            image: AssetImage("assets/graphics/empty.png"),
          ),
        ),
        Center(
          child: Text(
            text,
            style: TextStyle(color: Color.fromARGB(255, 63, 81, 181)),
          ),
        ),
        if (subTitle != null)
          Center(
            child: Text(
              subTitle!,
              style: TextStyle(color: Color.fromARGB(255, 63, 81, 181)),
            ),
          ),
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }
}
