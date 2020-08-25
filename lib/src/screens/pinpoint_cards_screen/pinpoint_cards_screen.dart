import 'package:flutter/material.dart';
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
  void _goFromCardsScreenToDetailed(PinPoint pinPoint, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CardDetailScreen(pinPoint: pinPoint),
      ),
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
              cardsScreenModalBottomSheet(pinPoints[index], index, context),
          child: Card(
            key: Key(pinPoints[index].id.toString()),
            child: cardListTileWidget(_getImage(context, pinPoints[index].id),
                pinPoints[index].title, pinPoints[index].location),
          ),
        );
      },
    );
  }

  _getImage(BuildContext ctx, int id) {
    Image img = Provider.of<PinPointsService>(ctx).getImage(id);
    return img;
  }
}
