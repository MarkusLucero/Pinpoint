import 'package:flutter/material.dart';

class CustomAddImageDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget myFlatButton(title, color, value) {
      return FlatButton(
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            textAlign: TextAlign.left,
            style: TextStyle(color: color),
          ),
        ),
        onPressed: () => Navigator.of(context).pop(value),
      );
    }

    return SimpleDialog(
      title: Text(
        'Add an image.',
      ),
      children: <Widget>[
        myFlatButton(
          'Choose an existing image',
          Colors.black,
          true,
        ),
        myFlatButton(
          'Capture a new image',
          Colors.black,
          false,
        ),
      ],
      contentPadding: EdgeInsets.only(
        top: 20,
        bottom: 7.5,
        left: 25,
        right: 25,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
