import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/navigation/tabs_navigation.dart';
import 'src/services/pinpoints_list_service.dart';

void main() => runApp(
      /* makes it so that we can reach state in any widget down the tree */
      ChangeNotifierProvider<PinPointsService>(
        child: MyApp(),
        create: (context) => PinPointsService(),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to our app!',
      home: TabBarNav(),
    );
  }
}
