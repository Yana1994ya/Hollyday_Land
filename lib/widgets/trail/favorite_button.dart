import "package:flutter/material.dart";
import "package:hollyday_land/models/trail/trail.dart";
import "package:hollyday_land/providers/favorites_cache_key.dart";
import "package:provider/provider.dart";

class TrailFavoriteButton extends StatefulWidget {
  final String trailId;
  final bool initialState;
  final String token;

  const TrailFavoriteButton({
    Key? key,
    required this.trailId,
    required this.initialState,
    required this.token,
  }) : super(key: key);

  @override
  State<TrailFavoriteButton> createState() => _TrailFavoriteButtonState();
}

class _TrailFavoriteButtonState extends State<TrailFavoriteButton> {
  bool favorite = false;
  bool working = false;

  @override
  void initState() {
    favorite = widget.initialState;
    super.initState();
  }

  void setFavorite(bool newValue) {
    setState(() {
      working = true;
    });

    Trail.setFavorite(widget.token, widget.trailId, newValue).then((_) {
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
