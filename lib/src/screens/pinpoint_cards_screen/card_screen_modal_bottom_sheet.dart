import 'package:flutter/material.dart';
import '../../models/pin_point_model.dart';
import '../../shapes/bottom_sheet_border_shape.dart';
import '../card_detail_screen/card_detail_screen.dart';
import './edit_modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import '../../services/pinpoints_list_service.dart';

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
    This function build the bottomSheet modal that shows up when long pressing a card
   */
void cardsScreenModalBottomSheet(
    PinPoint pinPoint, int index, BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: getBottomSheetShape(),
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
            onTap: () => editPullUpModal(pinPoint, index, context, "title"),
            leading: Icon(Icons.edit),
            title: Text("Edit title"),
          ),
          ListTile(
            onTap: () => editPullUpModal(pinPoint, index, context, "notes"),
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
