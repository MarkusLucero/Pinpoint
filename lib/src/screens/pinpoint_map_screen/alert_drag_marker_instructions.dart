import 'package:flutter/material.dart';

class AlertDragMarkerInstructions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Marker"),
      content: Text(
          "The PinPoint is now in movable mode. Hold down on the PinPoint on the map to detach and move it."),
      actions: <Widget>[
        FlatButton(
            child: Text("Ok"),
            onPressed: () {
              Navigator.of(context).pop();
            })
      ],
    );
  }
}
