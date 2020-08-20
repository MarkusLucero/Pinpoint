import 'package:flutter/material.dart';
import 'package:pinpoint/src/models/pin_point_model.dart';

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
        ),
      ),
    );
  }
}
