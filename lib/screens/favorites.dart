import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/login.dart';
import 'login.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);

    if (loginProvider.currentUser == null) {
      return LoginScreen(reason: "Please login to see your favorites");
    } else {
      return Center(
        child: Text("Welcome ${loginProvider.currentUser!.email}, " +
            "here you'll find your favorites"),
      );
    }
  }
}
