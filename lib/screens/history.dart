import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/login.dart';
import 'login.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);

    if (loginProvider.currentUser == null) {
      return const LoginScreen(reason: "Please login to see your history");
    } else {
      return Center(
        child: Text("Welcome ${loginProvider.currentUser!.email}, " +
            "here you'll find your history"),
      );
    }
  }
}
