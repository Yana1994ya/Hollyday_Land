import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'providers/login.dart';
import 'providers/root_categories.dart';
import 'screens/homepage.dart';

void main() {
  WidgetsFlutterBinding();
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
        ChangeNotifierProvider(create: (_) => RootCategoriesProvider())
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
