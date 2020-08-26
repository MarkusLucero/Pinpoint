import 'package:flutter/material.dart';
import 'package:pinpoint/src/models/pin_point_model.dart';

class CardDetailScreen extends StatelessWidget {
  final PinPoint pinPoint;
  final Image img;

  //kolla upp detta med nycklar
  CardDetailScreen({Key key, @required this.pinPoint, this.img})
      : super(key: key);

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: pinPoint.title + pinPoint.location, //FIXME: Shit tag?
                child: Center(
                  child: ClipRect(
                    child: img != null
                        ? Image(
                            image: img.image,
                            //fit: BoxFit.contain,
                            height: 250,
                          )
                        : Image(
                            image: AssetImage("assets/images/picNotFound.png"),
                            fit: BoxFit.contain,
                            height: 250,
                          ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 10,
                ),
                child: Text(
                  pinPoint.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 24,
                  ),
                ),
              ),
              Text(
                pinPoint.location.toUpperCase(),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 10,
                ),
                child: Text(
                  pinPoint.notes,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
