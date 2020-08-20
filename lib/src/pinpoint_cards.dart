import 'package:flutter/material.dart';
import 'package:pinpoint/src/models/pin_point_model.dart';
import 'screens/card_detail_screen.dart';

/*
 * Widget that lists all pinpoints as cards
 * The state used is the list which will change if the user adds/removes pinpoints 
 * TODO State shouldn't be in this widget - will fix when we get to the state management part
*/

class PinPointCards extends StatefulWidget {
  @override
  _PinPointCardsState createState() => _PinPointCardsState();
}

class _PinPointCardsState extends State<PinPointCards> {
  // contains all the user set pinpoints TODO: real data from pins set on the map over mockup
  final List<PinPoint> pinPoints = [
    PinPoint(
      title: "The best location",
      notes:
          "this place was actually pretty cool let me tell u that my friends",
      imgUrl: "https://medioteket.gavle.se/assets/img/error/img.png",
      location: "Uppsala",
    ),
    PinPoint(
      title: "The best location",
      notes:
          "this place was actually pretty cool let me tell u that my friends",
      imgUrl: "https://medioteket.gavle.se/assets/img/error/img.png",
      location: "Stockholm",
    ),
    PinPoint(
      title: "The best location",
      notes:
          "this place was actually pretty cool let me tell u that my friends",
      imgUrl:
          "https://images.unsplash.com/photo-1513002749550-c59d786b8e6c?ixlib=rb-1.2.1&w=1000&q=80",
      location: "Göteborg",
    ),
    PinPoint(
      title: "The best location",
      notes:
          "this place was actually pretty cool let me tell u that my friends",
      imgUrl: "https://medioteket.gavle.se/assets/img/error/img.png",
      location: "Paris",
    ),
    PinPoint(
      title: "The best location",
      notes:
          "this place was actually pretty cool let me tell u that my friends",
      imgUrl:
          "https://image.shutterstock.com/image-photo/bright-spring-view-cameo-island-260nw-1048185397.jpg",
      location: "London",
    ),
    PinPoint(
      title: "The best location",
      notes:
          "this place was actually pretty cool let me tell u that my friends",
      imgUrl:
          "https://cdn.pixabay.com/photo/2015/02/24/15/41/dog-647528__340.jpg",
      location: "Amsterdam",
    ),
  ];

  /* 
    This function is used to navigate to the detailed screen of a pinPoint after pressing
    "open" in the bottomSheet modal in CardsScreen
  */
  void _goFromModalToCardDetailScreen(PinPoint pinPoint) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CardDetailScreen(pinPoint: pinPoint),
      ),
    ).then((value) => Navigator.pop(context));
  }

  /* 
    This function build the bottomSheet modal that shows up when long pressing a card
   */
  void _cardsScreenModalBottomSheet(PinPoint pinPoint) {
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
              onTap: () => _goFromModalToCardDetailScreen(pinPoint),
              leading: Icon(Icons.launch),
              title: Text("Open"),
            ),
            ListTile(
              onTap: null, //TODO: go to edit view
              leading: Icon(Icons.edit),
              title: Text("Edit"),
            ),
            ListTile(
              onTap: null, //TODO: delete card
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
  void _goFromCardsScreenToDetailed(PinPoint pinPoint) {
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
    return ListView.builder(
      itemCount: this.pinPoints.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () => _goFromCardsScreenToDetailed(this.pinPoints[index]),
          onLongPress: () =>
              _cardsScreenModalBottomSheet(this.pinPoints[index]),
          child: Card(
            key:
                UniqueKey(), // TODO: objectKey instead since each object couldn't possibly be the same??
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _cardListTileWidget(
                    this.pinPoints[index].imgUrl,
                    this.pinPoints[index].title,
                    this.pinPoints[index].location),
              ],
            ),
          ),
        );
      },
    );
  }
}
