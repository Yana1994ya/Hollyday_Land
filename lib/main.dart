import 'package:flutter/material.dart';

import './my_homepage.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Hollyday Land';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: MyHomepageWidget(),
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.green.shade200,
      ),
    );
  }
}
