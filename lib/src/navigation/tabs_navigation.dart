import 'package:flutter/material.dart';
import '../screens/pinpoint_map_screen/pinpoint_map.dart';
import '../screens/pinpoint_cards_screen/pinpoint_cards_screen.dart';

class TabBarNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("PinPoint"),
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.pin_drop),
              ),
              Tab(
                icon: Icon(Icons.map),
              ),
            ],
          ),
        ),
        body: TabBarView(physics: NeverScrollableScrollPhysics(), children: [
          PinPointCardsScreen(),
          PinPointMapScreen(),
        ]),
      ),
    );
  }
}
