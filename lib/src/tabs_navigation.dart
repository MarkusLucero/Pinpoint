import 'package:flutter/material.dart';
import 'pinpoint_map.dart';
import 'pinpoint_card.dart';

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
          PinPointCard(),
          PinPointMap(),
        ]),
      ),
    );
  }
}
