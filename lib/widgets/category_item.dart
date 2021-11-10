import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String image;
  final String title;
  final String path;

  const CategoryItem({
    Key? key,
    required this.image,
    required this.title,
    required this.path,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(path);
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
            child: Text(title,
                style: Theme.of(context).textTheme.headline6)),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage(image),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
