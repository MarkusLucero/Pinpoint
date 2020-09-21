import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter/material.dart';
import '../../functions/hide_keyboard.dart';

class AddedMarkerModal extends StatefulWidget {
  final String title;
  final Function(String) updateTitleCallback;
  AddedMarkerModal({@required this.title, this.updateTitleCallback});

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
    return SingleChildScrollView(
      child: GestureDetector(
        onTap: () => hideKeyboard(context),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.80,
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SafeArea(
              child: ListView(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "My Pin Point",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      RawMaterialButton(
                        onPressed: () {
                          widget.updateTitleCallback(textController.text);
                          Navigator.of(context)
                              .pop(); //return to map - removes modal
                        },
                        shape: CircleBorder(),
                        child: Text(
                          "Save",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter title',
                    ),
                    controller: textController,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text("Select your marker icon:",
                        style: TextStyle(fontSize: 18)),
                  ),
                  GridView.count(
                    crossAxisCount: 4,
                    physics:
                        NeverScrollableScrollPhysics(), // to disable GridView's scrolling
                    shrinkWrap: true,
                    children: <Widget>[
                      Icon(FontAwesome5Solid.address_book),
                      Icon(Icons.ac_unit),
                      Icon(Icons.ac_unit)
                    ], // You won't see infinite size error
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
