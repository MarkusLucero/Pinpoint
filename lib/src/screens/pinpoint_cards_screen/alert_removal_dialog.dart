import 'package:flutter/material.dart';

class CustomAlertRemovalDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget myFlatButton(title, color, value) {
      return FlatButton(
        child: Text(
          title,
          style: TextStyle(color: color),
        ),
        onPressed: () => Navigator.of(context).pop(value),
      );
    }

    return AlertDialog(
      title: Text(
        'Confirm Deletion',
      ),
      content: Text(
        'Are you sure you want to delete this Pin Point?',
      ),
      actions: <Widget>[
        myFlatButton(
          'Delete',
          Colors.redAccent,
          true,
        ),
        myFlatButton('abort', Colors.grey[400], false),
      ],
      contentPadding:
          EdgeInsets.only(top: 20, bottom: 7.5, left: 25, right: 25),
      insetPadding: EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    );
  }
}
