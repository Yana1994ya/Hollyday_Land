import 'package:flutter/material.dart';
import 'package:hollyday_land/models/history.dart';
import 'package:hollyday_land/widgets/history_categories_grid.dart';
import 'package:provider/provider.dart';

import '../providers/login.dart';

class HistoryScreen extends StatelessWidget {
  static const routePath = "/history";

  Widget historyBody(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);


    if (loginProvider.currentUser == null) {
      //reason: "Please login to see your history"
      return Center(child: Text("login to view history"));
    } else {
      return FutureBuilder(
        future: History.readHistory(loginProvider.hdToken!),
        builder: (_, AsyncSnapshot<History> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("error: ${snapshot.error}"),);
          } else if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator(),);
          } else {
            return HistoryCategoriesGrid(history: snapshot.data!);
          }
        },);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("History"),
      ),
      body: historyBody(context),
    );
  }
}
