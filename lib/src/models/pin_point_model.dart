import 'package:meta/meta.dart';
import '../db/database_helper.dart';

class PinPoint {
  String title, notes, imgUrl, location, id;

  PinPoint({
    this.title,
    this.id,
    this.notes,
    this.imgUrl,
    this.location,
  });

  Map<String, dynamic> toMap() {
    var map = {
      DatabaseHelper.COLUMN_ID: this.id,
      DatabaseHelper.COLUMN_IMG: this.imgUrl,
      DatabaseHelper.COLUMN_LOCATION: this.location,
      DatabaseHelper.COLUMN_NOTES: this.notes,
      DatabaseHelper.COLUMN_TITLE: this.title,
    };

    // ID wont exist first time we create map
    if (this.id != null) {
      map[DatabaseHelper.COLUMN_ID] = this.id;
    }

    return map;
  }

  // convenience constructor to create a PinPoint obj from a table in db
  PinPoint.fromMap(Map<String, dynamic> map) {
    id = map[DatabaseHelper.COLUMN_ID];
    imgUrl = map[DatabaseHelper.COLUMN_IMG];
    location = map[DatabaseHelper.COLUMN_LOCATION];
    notes = map[DatabaseHelper.COLUMN_NOTES];
    title = map[DatabaseHelper.COLUMN_TITLE];
  }
}
