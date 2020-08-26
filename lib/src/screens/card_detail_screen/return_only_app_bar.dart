import 'package:flutter/material.dart';

/* Only an arrow is displayed that takes you back to previous screen. */
class ReturnOnlyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back, size: 25),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
