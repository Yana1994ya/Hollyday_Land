import "package:flutter/material.dart";
import "package:hollyday_land/models/image_asset.dart";

class FullScreenImage extends StatelessWidget {
  final ImageAsset image;

  const FullScreenImage({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Image")),
      body: Center(
        child: Image(
          image: NetworkImage(image.url),
        ),
      ),
    );
  }
}
