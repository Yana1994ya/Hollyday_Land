import "package:flutter/material.dart";
import "package:hollyday_land/models/favorites.dart";
import "package:hollyday_land/providers/favorites_cache_key.dart";
import "package:provider/provider.dart";

class FavoriteButton extends StatefulWidget {
  final int attractionId;
  final bool initalState;
  final String token;

  const FavoriteButton({
    Key? key,
    required this.attractionId,
    required this.initalState,
    required this.token,
  }) : super(key: key);

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool favorite = false;
  bool working = false;

  @override
  void initState() {
    favorite = widget.initalState;
    super.initState();
  }

  void setFavorite(bool newValue) {
    setState(() {
      working = true;
    });

    Favorites.setFavorite(widget.token, widget.attractionId, newValue)
        .then((_) {
      setState(() {
        working = false;
        favorite = newValue;
      });

      Provider.of<FavoritesCacheKey>(context, listen: false).refresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (working) {
      return CircularProgressIndicator();
    } else {
      if (favorite) {
        return IconButton(
          onPressed: () {
            setFavorite(false);
          },
          icon: Icon(Icons.favorite),
        );
      } else {
        return IconButton(
          onPressed: () {
            setFavorite(true);
          },
          icon: Icon(Icons.favorite_outline),
        );
      }
    }
  }
}
