import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/login.dart';
import 'profile.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);

    if (loginProvider.currentUser == null) {
      //reason: "Please login to see your favorites"
      return ProfileScreen();
    } else {
      return Center(
        child: Text("Welcome ${loginProvider.currentUser!.email}, " +
            "here you'll find your favorites"),
      );
    }
  }
}
