import 'package:flutter/material.dart';
import 'package:pinpoint/src/models/pin_point_model.dart';
import 'package:pinpoint/src/screens/card_detail_screen/return_only_app_bar.dart';

class CardDetailScreen extends StatelessWidget {
  final PinPoint pinPoint;
  final Image img;

  //kolla upp detta med nycklar
  CardDetailScreen({Key key, @required this.pinPoint, this.img})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReturnOnlyAppBar(),
              Hero(
                tag: pinPoint.title + pinPoint.location, //FIXME: Shit tag?
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                  ),
                  child: img != null
                      ? Image(
                          image: img.image,
                          fit: BoxFit.contain,
                          height: 250,
                        )
                      : Image(
                          image: AssetImage("assets/images/picNotFound.png"),
                          fit: BoxFit.contain,
                          height: 250,
                        ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Text(
                  pinPoint.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 24,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Text(
                  pinPoint.location.toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(
                  20,
                ),
                child: Text(
                  pinPoint.notes,
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
