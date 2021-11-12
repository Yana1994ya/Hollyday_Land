import 'package:flutter/material.dart';
import 'package:hollyday_land/models/history.dart';
import 'package:hollyday_land/widgets/history_categories_grid.dart';
import 'package:provider/provider.dart';

import '../providers/login.dart';

class _LoggedInHistoryScreen extends StatefulWidget {
  final LoginProvider loginProvider;

  const _LoggedInHistoryScreen({Key? key, required this.loginProvider})
      : super(key: key);

  @override
  State<_LoggedInHistoryScreen> createState() => _LoggedInHistoryScreenState();
}

class _LoggedInHistoryScreenState extends State<_LoggedInHistoryScreen> {
  History? history;
  bool loading = true;
  Error? error;

  @override
  Widget build(BuildContext context) {
    if (loading == true) {
      return Scaffold(
        appBar: AppBar(
          title: Text("History"),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text("Histroy"),
          actions: [
            IconButton(
              onPressed: () {
                loading = true;
                History.deleteHistory(widget.loginProvider.hdToken!)
                    .then((_){
                      setState(() {
                        loading = false;
                        history = History(museums: 0);
                      });
                    });
              },
              icon: Icon(Icons.delete),
            ),
          ],
        ),
        body: HistoryCategoriesGrid(history: history!),
      );
    }
  }

  @override
  void initState() {
    History.readHistory(widget.loginProvider.hdToken!).then((history) {
      setState(() {
        this.history = history;
        loading = false;
      });
    });
  }
}

class HistoryScreen extends StatelessWidget {
  static const routePath = "/history";

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);

    if (loginProvider.currentUser == null) {
      //reason: "Please login to see your history"
      return Scaffold(
        appBar: AppBar(
          title: Text("History"),
        ),
        body: Center(child: Text("login to view history")),
      );
    } else {
      return _LoggedInHistoryScreen(
        loginProvider: loginProvider,
      );
    }
  }
}
