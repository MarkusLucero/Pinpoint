import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pinpoint/src/models/pin_point_model.dart';
import 'card_detail_screen.dart';
import '../services/pinpoints_list_service.dart';

/*
 * Widget that lists all pinpoints as cards
 * The state used is the list which will change if the user adds/removes pinpoints 
*/

class PinPointCardsScreen extends StatelessWidget {
  /* 
    This function is used to navigate to the detailed screen of a pinPoint after pressing
    "open" in the bottomSheet modal in CardsScreen
  */
  void _goFromModalToCardDetailScreen(
      PinPoint pinPoint, BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CardDetailScreen(pinPoint: pinPoint),
      ),
    ).then((value) => Navigator.pop(context));
  }

  /* 
    Will remove the pinPoint from list after pressing the delete button on the bottomSheet modal of said pinPoint card
   */
  void _removePinPointFromList(int index, BuildContext context) {
    Provider.of<PinPointsService>(context, listen: false).remove(index);
    Navigator.pop(context); //hide modal after removing pinpoint
  }

  /* 
    Will edit the title of the pinPoint after pressing the check mark button
   */
  void _editTitleOfPinPointFromList(
      int index, String title, BuildContext context) {
    Provider.of<PinPointsService>(context, listen: false)
        .editTitle(index, title);
  }

  /* 
    Will edit the notes of the pinPoint after pressing the check mark button
   */
  void _editNotesOfPinPointFromList(
      int index, String notes, BuildContext context) {
    Provider.of<PinPointsService>(context, listen: false)
        .editNotes(index, notes);
  }

  /* 
    The shape of the top of the bottomSheet modal
   */
  RoundedRectangleBorder _getBottomSheetShape() {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10.0),
        topRight: Radius.circular(10.0),
      ),
    );
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
  void _showEditPullUpModal(PinPoint pinPoint, int index, BuildContext context,
      String whatIsBeingEdited) {
    // The textFields should show the title / notes that where previously there
    _controllerEditNotes.text = pinPoint.notes;
    _controllerEditTitle.text = pinPoint.title;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: _getBottomSheetShape(),
      builder: (context) => SingleChildScrollView(
        child: GestureDetector(
          onTap: () => _hideKeyboard(context),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.80,
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
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
                              if ((_controllerEditTitle.text !=
                                  pinPoint.title)) {
                                _editTitleOfPinPointFromList(
                                    index, _controllerEditTitle.text, context);
                              }
                            } else {
                              if ((_controllerEditNotes.text !=
                                  pinPoint.notes)) {
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

  /* 
    This function build the bottomSheet modal that shows up when long pressing a card
   */
  void _cardsScreenModalBottomSheet(
      PinPoint pinPoint, int index, BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: _getBottomSheetShape(),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              onTap: () => _goFromModalToCardDetailScreen(pinPoint, context),
              leading: Icon(Icons.launch),
              title: Text("Open"),
            ),
            ListTile(
              onTap: () =>
                  _showEditPullUpModal(pinPoint, index, context, "title"),
              leading: Icon(Icons.edit),
              title: Text("Edit title"),
            ),
            ListTile(
              onTap: () =>
                  _showEditPullUpModal(pinPoint, index, context, "notes"),
              leading: Icon(Icons.edit),
              title: Text("Edit notes"),
            ),
            ListTile(
              onTap: () => _removePinPointFromList(index, context),
              leading: Icon(Icons.delete),
              title: Text("Delete"),
            )
          ],
        ),
      ),
    );
  }

  /* 
    This function is used to navigate to the detailed screen of a pinPoint after tapping
    on a card
  */
  void _goFromCardsScreenToDetailed(PinPoint pinPoint, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CardDetailScreen(pinPoint: pinPoint),
      ),
    );
  }

  Widget _cardListTileWidget(String imgUrl, String title, String location) {
    return ListTile(
      leading: Hero(
        tag: imgUrl + title + location, // FIXME: Shit tag?
        child: CircleAvatar(
          backgroundColor: Colors.amber[100],
          backgroundImage: NetworkImage(
            imgUrl,
          ),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(location.toUpperCase()),
      dense: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    //Get pinpoints from shared data service
    List<PinPoint> pinPoints = Provider.of<PinPointsService>(context).pinPoints;
    return ListView.builder(
      itemCount: pinPoints.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () => _goFromCardsScreenToDetailed(pinPoints[index], context),
          onLongPress: () =>
              _cardsScreenModalBottomSheet(pinPoints[index], index, context),
          child: Card(
            key:
                UniqueKey(), // TODO: objectKey instead since each object couldn't possibly be the same??
            child: _cardListTileWidget(pinPoints[index].imgUrl,
                pinPoints[index].title, pinPoints[index].location),
          ),
        );
      },
    );
  }
}
