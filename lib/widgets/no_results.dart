import "package:flutter/material.dart";

class NoResults extends StatelessWidget {
  final String text;

  const NoResults({Key? key, required this.text}) : super(key: key);

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
          style: TextStyle(color: Color.fromARGB(255, 128, 122, 158)),
        )),
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }
}
