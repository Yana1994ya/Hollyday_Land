import "package:carousel_slider/carousel_slider.dart";
import "package:flutter/material.dart";
import "package:hollyday_land/models/image_asset.dart";
import "package:hollyday_land/screens/full_screen_image.dart";

class ImageCarousel extends StatelessWidget {
  final List<ImageAsset> images;

  const ImageCarousel({Key? key, required this.images}) : super(key: key);

  static List<ImageAsset> collectImages(
    ImageAsset? mainImage,
    List<ImageAsset> additionalImages,
  ) {
    return [if (mainImage != null) mainImage, ...additionalImages];
  }

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
          width: double.infinity,
          height: 300.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/graphics/icon.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    } else if (images.length == 1) {
      return GestureDetector(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Container(
            width: double.infinity,
            height: 300.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(images[0].url),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => FullScreenImage(
                  image: images[0].parent == null
                      ? images[0]
                      : images[0].parent!)));
        },
      );
    } else {
      return CarouselSlider(
        options: CarouselOptions(height: 300.0),
        items: images.map((image) {
          return Builder(
            builder: (BuildContext context) {
              return GestureDetector(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(image.url),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => FullScreenImage(
                          image:
                              image.parent == null ? image : image.parent!)));
                },
              );
            },
          );
        }).toList(),
      );
    }
  }
}
