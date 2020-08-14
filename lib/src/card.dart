import 'package:flutter/material.dart';
import 'package:pinpoint/src/models/pin_point_model.dart';

class PinPointCard extends StatelessWidget {

  // Test PinPoint data
  final PinPoint pinPoint = PinPoint(
    title: "The best location",
    notes: "this place was actually pretty cool let me tell u that my friends",
    imgUrl: null,
    location: "Uppsala",
  );

  @override
  Widget build(BuildContext context) {
    return Card();
  }
}
