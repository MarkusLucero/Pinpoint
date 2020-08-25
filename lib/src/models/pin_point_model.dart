import '../db/database_helper.dart';

class PinPoint {
  int id;
  String title, notes, img, location;

  PinPoint({
    this.title,
    this.notes,
    this.img,
    this.location,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      DatabaseHelper.COLUMN_ID: this.id,
      DatabaseHelper.COLUMN_IMG: this.img,
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
    img = map[DatabaseHelper.COLUMN_IMG];
    location = map[DatabaseHelper.COLUMN_LOCATION];
    notes = map[DatabaseHelper.COLUMN_NOTES];
    title = map[DatabaseHelper.COLUMN_TITLE];
  }
}
