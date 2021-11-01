import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  final Widget child;

  const BackgroundWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage("assets/graphics/background.jpg"),
        fit: BoxFit.fill,
      )),
    );
  }
}
