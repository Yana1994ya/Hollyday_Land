import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hollyday_land/models/museum/museum.dart';
import 'package:hollyday_land/models/museum/museum_short.dart';

class MuseumScreen extends StatefulWidget {
  final MuseumShort museum;

  const MuseumScreen({Key? key, required this.museum}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MuseumScreenState();
}

class _MuseumScreenState extends State<MuseumScreen> {
  late final Future<Museum> loadingMuseum;

  @override
  void initState() {
    loadingMuseum = Museum.readMuseum(widget.museum.id);
  }

  Widget displayImages(final List<Image> images, BuildContext context){
    if(images.length == 1){
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
                  )
              );
            },
          );
        }).toList(),
      );
    }
  }

  Widget buildMuseum(final Museum museum, BuildContext context) {
    final List<Image> images = [
      museum.mainImage == null
          ? Image.asset(
              "assets/graphics/icon.png",
              fit: BoxFit.cover,
            )
          : Image.network(
              museum.mainImage!.url,
              fit: BoxFit.cover,
            ),
      ...museum.additionalImages
          .map((image) => Image.network(image.url, fit: BoxFit.cover))
    ];

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: displayImages(images, context)
          ),
          Text(museum.name, style: Theme.of(context).textTheme.headline6,),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(museum.description),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.museum.name),
      ),
      body: FutureBuilder(
        future: loadingMuseum,
        builder: (_, AsyncSnapshot<Museum> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            );
          } else if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return buildMuseum(snapshot.data!, context);
          }
        },
      ),
    );
  }
}
