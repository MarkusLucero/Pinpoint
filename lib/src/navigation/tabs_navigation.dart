import 'package:flutter/material.dart';
import 'package:pinpoint/src/navigation/custom_tab_app_bar.dart';
import '../screens/pinpoint_map_screen/pinpoint_map.dart';
import '../screens/pinpoint_cards_screen/pinpoint_cards_screen.dart';

class TabBarNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: CustomTabAppBar(),
        ),
        body: TabBarView(physics: NeverScrollableScrollPhysics(), children: [
          PinPointCardsScreen(),
          PinPointMapScreen(),
        ]),
      ),
    );
  }
}
