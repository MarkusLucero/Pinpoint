import 'package:flutter/material.dart';

/* Only an arrow is displayed that takes you back to previous screen. */
class CustomTabAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(10),
        child: TabBar(
          indicatorColor: Colors.transparent,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.black54,
          tabs: [
            Tab(
              icon: Icon(
                Icons.pin_drop,
                size: 25,
              ),
            ),
            Tab(
              icon: Icon(
                Icons.map,
                size: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
