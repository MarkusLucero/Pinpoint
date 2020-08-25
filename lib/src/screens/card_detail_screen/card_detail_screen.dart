import 'package:flutter/material.dart';
import 'package:pinpoint/src/models/pin_point_model.dart';
import 'package:pinpoint/src/services/pinpoints_list_service.dart';
import 'package:provider/provider.dart';

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: pinPoint.title + pinPoint.location, //FIXME: Shit tag?
                child: Center(
                  child: _getImage(context, pinPoint.id),
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

  Widget _getImage(BuildContext ctx, int id) {
    Image img = Provider.of<PinPointsService>(ctx).getImage(id);
    return ClipRect(
      child: img != null
          ? Image(
              image: img.image,
              //fit: BoxFit.contain,
              height: 250,
            )
          : Image.network(
              "https://medioteket.gavle.se/assets/img/error/img.png", //FIXME: use img from assets folder
              fit: BoxFit.contain,
              height: 250,
            ),
    );
  }
}
