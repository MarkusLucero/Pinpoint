import '../db/database_helper.dart';

class InternalMarker {
  int id;
  double latitude;
  double longitude;
  String title;
  int pinPointId;

  InternalMarker({
    this.latitude,
    this.longitude,
    this.title,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      DatabaseHelper.COLUMN_ID: this.id,
      DatabaseHelper.COLUMN_LONG: this.longitude,
      DatabaseHelper.COLUMN_LAT: this.latitude,
      DatabaseHelper.COLUMN_TITLE: this.title,
      DatabaseHelper.COLUMN_FK_P: this.pinPointId,
    };

    if (this.id != null) {
      map[DatabaseHelper.COLUMN_ID] = this.id;
    }
    return map;
  }

  InternalMarker.fromMap(Map<String, dynamic> map) {
    id = map[DatabaseHelper.COLUMN_ID];
    longitude = map[DatabaseHelper.COLUMN_LONG];
    latitude = map[DatabaseHelper.COLUMN_LAT];
    title = map[DatabaseHelper.COLUMN_TITLE];
    pinPointId = map[DatabaseHelper.COLUMN_FK_P];
  }
}
