import 'package:flutter/material.dart';
import 'package:pinpoint/src/screens/pinpoint_cards_screen/alert_removal_dialog.dart';
import 'package:provider/provider.dart';
import '../../models/pin_point_model.dart';
import '../card_detail_screen/card_detail_screen.dart';
import '../../services/pinpoints_list_service.dart';
import './card_list_tile_widget.dart';
import './card_screen_modal_bottom_sheet.dart';

/*
 * Widget that lists all pinpoints as cards
 * The state used is the list which will change if the user adds/removes pinpoints 
*/

class PinPointCardsScreen extends StatelessWidget {
  /* 
    This function is used to navigate to the detailed screen of a pinPoint after tapping
    on a card
  */
  void _goFromCardsScreenToDetailed(
      PinPoint pinPoint, BuildContext context, Image img) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CardDetailScreen(pinPoint: pinPoint, img: img),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //Get pinpoints from shared data service
    List<PinPoint> pinPoints = Provider.of<PinPointsService>(context).pinPoints;
    return SafeArea(
      child: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: pinPoints.length,
        itemBuilder: (context, index) {
          Image img = _getImage(
              context,
              pinPoints[index]
                  .id); //FIXME: just use the imgstring in pinPoint here instead of fetching again??
          return Dismissible(
            key: Key(pinPoints[index].id.toString()),
            direction: DismissDirection.endToStart,
            onDismissed: (dir) {
              Provider.of<PinPointsService>(context, listen: false)
                  .remove(index);
            },
            confirmDismiss: (dir) {
              return showDialog(
                  context: context,
                  builder: (context) => CustomAlertRemovalDialog());
            },
            child: Card(
              margin: EdgeInsets.all(7.5),
              elevation: 2, // adds shadow

              child: InkWell(
                borderRadius: BorderRadius.circular(5),
                onTap: () => _goFromCardsScreenToDetailed(
                    pinPoints[index], context, img),
                onLongPress: () => cardsScreenModalBottomSheet(
                    pinPoints[index], index, context, img),
                child: cardListTileWidget(
                    img, pinPoints[index].title, pinPoints[index].location),
              ),
            ),
            background: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Align(
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.delete_forever,
                  color: Colors.redAccent,
                  size: 25,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _getImage(BuildContext ctx, int id) {
    Image img = Provider.of<PinPointsService>(ctx).getImage(id);
    return img;
  }
}
