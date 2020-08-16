import 'package:flutter/material.dart';
import 'src/pinpoint_map.dart';
import 'src/tabs_navigation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to our app!',
      home:  TabBarNav(),
    );
  }
}
