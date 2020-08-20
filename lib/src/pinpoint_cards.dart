import 'package:flutter/material.dart';
import 'package:pinpoint/src/models/pin_point_model.dart';

/*
 * Widget that lists all pinpoints as cards
 * The state used is the list which will change if the user adds/removes pinpoints 
 * TODO State probably shouldnt be in this widget - will fix when we get to the state management part
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

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.pinPoints.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    CardDetailScreen(pinPoint: this.pinPoints[index]),
              ),
            ),
          },
          onLongPress: () => {
            showModalBottomSheet(
              context: context,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5.0),
                topRight: Radius.circular(5.0),
              )),
              builder: (context) => SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      onTap: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CardDetailScreen(
                                pinPoint: this.pinPoints[index]),
                          ),
                        ).then((value) => Navigator.pop(
                            context)); // This removes the modal when we go back from screen
                      },
                      leading: Icon(Icons.launch),
                      title: Text("Open"),
                    ),
                    ListTile(
                      onTap: null,
                      leading: Icon(Icons.edit),
                      title: Text("Edit"),
                    ),
                    ListTile(
                      onTap: null,
                      leading: Icon(Icons.delete),
                      title: Text("Delete"),
                    )
                  ],
                ),
              ),
            ),
          },
          child: Card(
            key: UniqueKey(), // TODO objectKey instead??
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  child: Image.network(
                    "${this.pinPoints[index].imgUrl}",
                    // width: 300,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                // TODO: Adding trailing icon to be tap-able for submenu
                ListTile(
                  title: Text(
                    "${this.pinPoints[index].title}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle:
                      Text("${this.pinPoints[index].location}".toUpperCase()),
                  dense: true,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CardDetailScreen extends StatelessWidget {
  final PinPoint pinPoint;

  //kolla upp detta med nycklar
  CardDetailScreen({Key key, @required this.pinPoint}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pin Point"),
      ),
      body: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ClipRRect(
                  child: Image.network(
                    "${pinPoint.imgUrl}",
                    fit: BoxFit.contain,
                    height: 250,
                  ),
                ),
                // TODO: This shouldnt be a ListTile..
                ListTile(
                  title: Text(
                    "${pinPoint.title}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text("${pinPoint.location}".toUpperCase()),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.edit),
                  ),
                ),
                Text("${pinPoint.notes}"),
              ],
            ),
          )),
    );
  }
}
