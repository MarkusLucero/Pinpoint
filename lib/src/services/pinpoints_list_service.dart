import 'dart:io';
import 'dart:typed_data';

import 'package:pinpoint/src/db/database_helper.dart';
import 'package:pinpoint/src/functions/base64.dart';
import 'package:pinpoint/src/models/shared_data_tuple_model.dart';
import 'package:pinpoint/src/models/internal_marker_model.dart';
import 'package:pinpoint/src/screens/card_detail_screen/card_detail_screen.dart';
import '../models/pin_point_model.dart';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SharedData {
  List<PinPoint> pinPoints;
  List<InternalMarker> markers;

  SharedData(this.pinPoints, this.markers);
}

class PinPointsService extends ChangeNotifier {
  // Internal, private state of the pin points and markers
  SharedData _sharedData = SharedData([], []);

  // this service will att first load call _refreshPinPoints() to populate the sharedData with data from DB
  PinPointsService() {
    _refreshPinPoints();
  }

  // An unmodifiable view of the items in the cart.
  UnmodifiableListView<PinPoint> get pinPoints =>
      UnmodifiableListView(_sharedData.pinPoints);

  // An unmodifiable view of the markers stored on the map.
  // since we store them with our own datatype we need to convert them to type Marker
  UnmodifiableListView<InternalMarker> get markers =>
      UnmodifiableListView(_sharedData.markers);

/* 
  Will make a call to db instance to update the data of _sharedData to correspond with the data in db
  So each change of state will always make sure that the db corresponds with _sharedData 
  /FIXME: is this good practice????
 */
  Future _refreshPinPoints() async {
    DatabaseHelper databaseHelper = DatabaseHelper.db;
    _sharedData.pinPoints = await databaseHelper.getPinPoints();
/*     _sharedData.pinPoints.forEach((element) {
      print("in shared data pinPoint: ${element.toMap()}");
    }); */
    _sharedData.markers = await databaseHelper.getMarkers();

    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void add(PinPoint pinPoint, InternalMarker marker) async {
    DatabaseHelper databaseHelper = DatabaseHelper.db;
    SharedDataTuple sd = await databaseHelper.insert(pinPoint, marker);
    //sd is the pinpoint and marker inserted into the db
    _refreshPinPoints();
  }

  void remove(/* PinPoint pinPoint */ int index) async {
    PinPoint toBeRemoved = _sharedData.pinPoints[index];
    DatabaseHelper databaseHelper = DatabaseHelper.db;
    await databaseHelper.delete(toBeRemoved.id);
    _refreshPinPoints();
  }

  void editTitle(int index, String title) async {
    if (title != "") {
      PinPoint pinPoint = _sharedData.pinPoints[index];
      pinPoint.title = title;
      InternalMarker marker = _getMarkerOfItsPinPointId(pinPoint.id);
      marker.title = title;
      DatabaseHelper databaseHelper = DatabaseHelper.db;
      await databaseHelper.update(pinPoint, marker, true);
      _refreshPinPoints();
    } else {
      return;
    }
  }

  InternalMarker _getMarkerOfItsPinPointId(int pinPointId) {
    InternalMarker found;
    _sharedData.markers.forEach((marker) {
      if (marker.pinPointId == pinPointId) {
        found = marker;
      }
    });
    return found;
  }

  InternalMarker _getMarkerOf(int markerId) {
    InternalMarker found;
    _sharedData.markers.forEach((marker) {
      if (marker.id == markerId) {
        found = marker;
      }
    });
    return found;
  }

  PinPoint _getPinPointOf(int pinPointId) {
    PinPoint found;
    _sharedData.pinPoints.forEach((pinPoint) {
      if (pinPoint.id == pinPointId) {
        found = pinPoint;
      }
    });
    return found;
  }

/* Fetch marker of corresponding pinPoint id */
  InternalMarker fetchMarkerOfItsPinPointId(int pinPointId) {
    return _getMarkerOfItsPinPointId(pinPointId);
  }

/* Fetch marker of corresponding marker id */
  InternalMarker fetchMarker(int markerId) {
    return _getMarkerOf(markerId);
  }

/* Fetch pinPoint of corresponding pinPoint id */
  PinPoint fetchPinPoint(int pinPointId) {
    return _getPinPointOf(pinPointId);
  }

  void editNotes(int index, String notes) async {
    PinPoint pinPoint = _sharedData.pinPoints[index];
    pinPoint.notes = notes;
    DatabaseHelper databaseHelper = DatabaseHelper.db;
    await databaseHelper.update(pinPoint, null, false);
    _refreshPinPoints();
  }

  void editImage(int pinPointId, File imgFile) async {
    Uint8List imgBytes = imgFile.readAsBytesSync();
    String base64Image = base64String(imgBytes);
    PinPoint pinPoint = _getPinPointOf(pinPointId);
    pinPoint.img = base64Image;
    DatabaseHelper databaseHelper = DatabaseHelper.db;
    await databaseHelper.update(pinPoint, null, false);
    _refreshPinPoints();
  }

  Image getImage(int pinPointId) {
    PinPoint pinPoint = _getPinPointOf(pinPointId);
    if (pinPoint.img == "") return null;
    Uint8List dataBytes = dataFromBase64String(pinPoint.img);
    Image img = Image.memory(dataBytes);
    return img;
  }
}
