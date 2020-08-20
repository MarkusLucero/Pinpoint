import '../models/pin_point_model.dart';
import 'dart:collection';
import 'package:flutter/material.dart';

class PinPointsService extends ChangeNotifier {
  // Internal, private state of the pin points
  // TODO: FETCH REAL DATA FROM USER DEVICE STORAGE
  final List<PinPoint> _pinPoints = [
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

  // An unmodifiable view of the items in the cart.
  UnmodifiableListView<PinPoint> get pinPoints =>
      UnmodifiableListView(_pinPoints);

  // Adds [pinPoint] to list. This is the only way to modify the list from outside.
  void add(PinPoint pinPoint) {
    _pinPoints.add(pinPoint);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  // remove pinpoint at index from the list. //TODO: perhaps better to use index? since widget will show in same order as list here
  void remove(/* PinPoint pinPoint */ int index) {
    _pinPoints.removeAt(index);
    notifyListeners();
  }

  // edit pinpoint at index in list, [edited_title, edited_notes]
  void edit(int index, List<String> args) {
    if ((args.length > 2 || args.length == 0) ||
        (args[0] == "" && args[1] == "")) {
      return; // can only edit title and notes since img is changed from other place and location is retrieved from marker on the map.
    } else {
      if (args[0] != "") {
        _pinPoints[index].title = args[0];
      }
      if (args[1] != "") {
        _pinPoints[index].notes = args[1];
      }
    }
    notifyListeners();
  }

  // TODO:
  void editLocationByMovingMarker() {}
  // TODO:
  void changeImageOfPinPoint() {}
}
