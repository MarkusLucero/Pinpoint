import 'package:flutter/cupertino.dart';
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
                children: [
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
