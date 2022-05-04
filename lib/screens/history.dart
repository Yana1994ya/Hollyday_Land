import "package:flutter/material.dart";
import "package:hollyday_land/models/attractions_count.dart";
import "package:hollyday_land/models/history.dart";
import "package:hollyday_land/providers/login.dart";
import "package:hollyday_land/screens/profile.dart";
import "package:hollyday_land/widgets/history_categories_grid.dart";
import "package:hollyday_land/widgets/no_results.dart";
import "package:provider/provider.dart";

class _LoggedInHistoryScreen extends StatefulWidget {
  final LoginProvider loginProvider;

  const _LoggedInHistoryScreen({Key? key, required this.loginProvider})
      : super(key: key);

  @override
  State<_LoggedInHistoryScreen> createState() => _LoggedInHistoryScreenState();
}

class _LoggedInHistoryScreenState extends State<_LoggedInHistoryScreen> {
  AttractionsCount? history;
  bool loading = true;
  Error? error;

  bool get canClear {
    if (history == null) {
      return false;
    }

    return !(history!.isEmpty);
  }

  Future<bool?> confirmClear(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Delete history"),
        content: const Text("Are you sure you want to delete all history"),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text("No")),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text("Yes")),
        ],
      ),
    );
  }

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
          title: Text("History"),
          actions: [
            if (canClear)
              IconButton(
                onPressed: () {
                  confirmClear(context).then((value) {
                    if (value != null && value) {
                      // Show loading indicator
                      setState(() {
                        loading = true;
                      });

                      History.deleteHistory(widget.loginProvider.hdToken!)
                          .then((_) {
                        setState(() {
                          loading = false;
                          history = AttractionsCount.empty();
                        });
                      });
                    }
                  });
                },
                icon: Icon(Icons.delete),
              ),
          ],
        ),
        body: history!.isEmpty
            ? const NoResults(text: "You haven't visited any attractions yet")
            : HistoryCategoriesGrid(history: history!),
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

    super.initState();
  }
}

class HistoryScreen extends StatelessWidget {
  static const routePath = "/history";

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);

    if (loginProvider.currentUser == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text("History"),
        ),
        body: ProfileScreen.loginBody(context, loginProvider),
      );
    } else {
      return _LoggedInHistoryScreen(
        loginProvider: loginProvider,
      );
    }
  }
}
