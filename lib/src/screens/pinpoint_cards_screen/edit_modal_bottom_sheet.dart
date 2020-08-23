import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/pinpoints_list_service.dart';
import '../../shapes/bottom_sheet_border_shape.dart';
import '../../models/pin_point_model.dart';

/* 
    Will edit the title of the pinPoint after pressing the check mark button
   */
void _editTitleOfPinPointFromList(
    int index, String title, BuildContext context) {
  Provider.of<PinPointsService>(context, listen: false).editTitle(index, title);
}

/* 
    Will edit the notes of the pinPoint after pressing the check mark button
   */
void _editNotesOfPinPointFromList(
    int index, String notes, BuildContext context) {
  Provider.of<PinPointsService>(context, listen: false).editNotes(index, notes);
}

void _hideKeyboard(BuildContext ctx) {
  // Will remove the keyboard
  FocusScopeNode currentFocus = FocusScope.of(ctx);
  if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
  }
}

/* 
    Used to store the text of input to TextFields in _showEditPullUpModal
   */
TextEditingController _controllerEditNotes = new TextEditingController();
TextEditingController _controllerEditTitle = new TextEditingController();

/* 
  Will pull up a modal with textField which will allow the user to edit the title or notes of a pinpoint;
 */
void editPullUpModal(PinPoint pinPoint, int index, BuildContext context,
    String whatIsBeingEdited) {
  // The textFields should show the title / notes that where previously there
  _controllerEditNotes.text = pinPoint.notes;
  _controllerEditTitle.text = pinPoint.title;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: getBottomSheetShape(),
    builder: (context) => SingleChildScrollView(
      child: GestureDetector(
        onTap: () => _hideKeyboard(context),
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
                    children: [
                      Text(
                        whatIsBeingEdited == "title" ? "Title" : "Notes",
                        style: TextStyle(
                          //height: 3,
                          fontSize: 18,
                        ),
                      ),
                      IconButton(
                        color: Colors.green[200],
                        icon: Icon(
                          Icons.check_circle,
                        ),
                        onPressed: () {
                          _hideKeyboard(context);
                          // only update if user has actually written something new
                          if (whatIsBeingEdited == "title") {
                            if ((_controllerEditTitle.text != pinPoint.title)) {
                              _editTitleOfPinPointFromList(
                                  index, _controllerEditTitle.text, context);
                            }
                          } else {
                            if ((_controllerEditNotes.text != pinPoint.notes)) {
                              _editNotesOfPinPointFromList(
                                  index, _controllerEditNotes.text, context);
                            }
                          }
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                  TextField(
                    controller: whatIsBeingEdited == "title"
                        ? _controllerEditTitle
                        : _controllerEditNotes,
                    autofocus: true,
                    cursorColor: Colors.amber,
                    maxLines: whatIsBeingEdited == "title" ? 1 : 10,
                    keyboardType: whatIsBeingEdited == "title"
                        ? TextInputType.text
                        : TextInputType.multiline,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
