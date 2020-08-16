import 'package:flutter/material.dart';
import 'package:pinpoint/src/models/pin_point_model.dart';

// class PinPointCard extends StatelessWidget {
//   // Test PinPoint data
//   PinPoint pinPoint;

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Container(),
//     );
//   }
// }

class PinPointCards extends StatefulWidget {
  @override
  _PinPointCardsState createState() => _PinPointCardsState();
}

class _PinPointCardsState extends State<PinPointCards> {
  List<PinPoint> pinPoints = [
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
      imgUrl: "https://medioteket.gavle.se/assets/img/error/img.png",
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
      imgUrl: "https://medioteket.gavle.se/assets/img/error/img.png",
      location: "London",
    ),
    PinPoint(
      title: "The best location",
      notes:
          "this place was actually pretty cool let me tell u that my friends",
      imgUrl: "https://medioteket.gavle.se/assets/img/error/img.png",
      location: "Amsterdam",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.pinPoints.length,
      itemBuilder: (context, index) {
        // TODO: Implement the Card as designed in Figma doc
        return Card(
          key: UniqueKey(), // TODO objectKey instead??
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
                "${this.pinPoints != null ? this.pinPoints[index].location : "Missing Location Info...."}"),
          ),
        );
      },
    );
  }
}
