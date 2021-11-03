import 'package:flutter/material.dart';
import 'package:hollyday_land/screens/explore.dart';

import '../models/category.dart';

class CategoryItem extends StatelessWidget {
  final Category category;
  final SelectCategory selectCategory;

  const CategoryItem(this.category, this.selectCategory);

  @override
  Widget build(BuildContext context) {
    final image = category.image == null
        ? Image.asset("assets/graphics/icon.png")
        : Image.network(category.image!.url);

    return InkWell(
      onTap: () {
        this.selectCategory(category);
      },
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  //Colors.grey.shade400.withOpacity(0.9),
                  //Colors.grey.shade400.withOpacity(0)
                  Colors.white.withOpacity(0.7),
                  Colors.white.withOpacity(0),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(category.title,
                style: Theme.of(context).textTheme.headline6)),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: image.image,
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
