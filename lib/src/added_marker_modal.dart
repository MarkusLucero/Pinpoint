import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddedMarkerModal extends StatefulWidget {
  String title;
  AddedMarkerModal({@required this.title});

  @override
  _AddedMarkerModalState createState() => _AddedMarkerModalState();
}

class _AddedMarkerModalState extends State<AddedMarkerModal> {
  final textController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return (Container(
      padding: EdgeInsets.all(10.0),
      height: 150,
      child: ListView(children: [
        TextField(
          decoration: InputDecoration(
            hintText: 'Enter title',
          ),
          controller: textController,
        ),
        Row(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 60.0,
                  height: 60.0,
                  child: RawMaterialButton(
                    onPressed: () => setState(() {
                      widget.title = textController.text;
                    }),
                    shape: CircleBorder(),
                    child: Text(
                      "Save",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
              ],
            ),
          ],
        )
      ]),
    ));
  }
}
