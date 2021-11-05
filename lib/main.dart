import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import 'providers/login.dart';
import 'providers/root_categories.dart';
import 'providers/selected_categories.dart';
import 'screens/homepage.dart';

void main() {
  // Required for login
  WidgetsFlutterBinding();
  // Prevent landscape mode, not supported for this app.
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Hollyday Land';

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => RootCategoriesProvider()),
        ChangeNotifierProvider(create: (_) => SelectedCategoriesProvider())
      ],
      child: MaterialApp(
        title: _title,
        home: HomepageScreen(),
        theme: ThemeData(
          colorScheme:
              ColorScheme.fromSwatch(primarySwatch: Colors.indigo).copyWith(
            secondary: Colors.indigo[200],
          ),
        ),
      ),
    );
  }
}
