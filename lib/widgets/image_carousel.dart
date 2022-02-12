import "package:carousel_slider/carousel_slider.dart";
import "package:flutter/cupertino.dart";
import "package:hollyday_land/models/image_asset.dart";

class ImageCarousel extends StatelessWidget {
  final List<Image> images;

  const ImageCarousel({Key? key, required this.images}) : super(key: key);

  static List<Image> collectImages(
      ImageAsset? mainImage, List<ImageAsset> additionalImages) {
    return [
      mainImage == null
          ? Image.asset(
              "assets/graphics/icon.png",
              fit: BoxFit.cover,
            )
          : Image.network(
              mainImage.url,
              fit: BoxFit.cover,
            ),
      ...additionalImages
          .map((image) => Image.network(image.url, fit: BoxFit.cover)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    if (images.length == 1) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
          width: double.infinity,
          height: 300.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: images[0].image,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    } else {
      return CarouselSlider(
        options: CarouselOptions(height: 300.0),
        items: images.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: i.image,
                      fit: BoxFit.cover,
                    ),
                  ));
            },
          );
        }).toList(),
      );
    }
  }
}
