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
    This function build the bottomSheet modal that shows up when long pressing a card
   */
  void _cardsScreenModalBottomSheet(
      PinPoint pinPoint, int index, BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
      ),
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
              onTap: null, //TODO: go to edit view
              leading: Icon(Icons.edit),
              title: Text("Edit"),
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
      leading: CircleAvatar(
        backgroundColor: Colors.amber[100],
        backgroundImage: NetworkImage(
          imgUrl,
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
    // contains all the user set pinpoints TODO: real data from pins set on the map over mockup
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
