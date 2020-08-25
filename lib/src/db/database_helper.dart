import 'package:pinpoint/src/models/internal_marker_model.dart';
import 'package:pinpoint/src/models/shared_data_tuple_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/pin_point_model.dart';

class DatabaseHelper {
  /* NAME CONSTANTS */
  // change the name of DATABASE to get fresh db to work with in sim,
  // or turn of and on the sim again
  static const String DATABASE = "pinPointDB.db";
  static const int DATABASE_VERSION = 1;
  static const String TABLE_PINPOINT = 'pinPoint';
  static const String TABLE_MARKER = 'marker';
  static const String COLUMN_ID = '_id';
  static const String COLUMN_TITLE = 'title';
  static const String COLUMN_LOCATION = 'location';
  static const String COLUMN_NOTES = 'notes';
  static const String COLUMN_IMG = 'img';
  static const String COLUMN_LONG = 'long';
  static const String COLUMN_LAT = 'lat';
  static const String COLUMN_FK_M = 'markerId';
  static const String COLUMN_FK_P = "pinPointId";

  // makes it a singleton class
  DatabaseHelper._();
  // we access the database from this db object
  static final DatabaseHelper db = DatabaseHelper._();

  static Database _database;

  static Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

/* the getter for the database */
  Future<Database> get database async {
    print("db called");
    if (_database != null) {
      return _database;
    }
    //create the database if it doesn't exist
    _database = await _initializeDatabase();

    return _database;
  }

/* 
  Initialize the db and insert the two tables
 */
  Future<Database> _initializeDatabase() async {
    // gets the db path on android or ios
    String dbPath = await getDatabasesPath();
    return await openDatabase(
      join(dbPath, DATABASE),
      version: DATABASE_VERSION,
      onConfigure: _onConfigure,
      onCreate: (Database database, int version) async {
        print("init pinPoint table in db");
        await database.execute(
          "CREATE TABLE $TABLE_PINPOINT("
          "$COLUMN_ID INTEGER PRIMARY KEY,"
          "$COLUMN_LOCATION TEXT,"
          "$COLUMN_TITLE TEXT,"
          "$COLUMN_NOTES TEXT,"
          "$COLUMN_IMG TEXT"
          // "FOREIGN KEY($COLUMN_FK_M) REFERENCES $TABLE_MARKER($COLUMN_ID)" /* FIXME: one to one relationship */
          ")",
        );
        await database.execute(
          "CREATE TABLE $TABLE_MARKER("
          "$COLUMN_ID INTEGER PRIMARY KEY,"
          "$COLUMN_LONG REAL,"
          "$COLUMN_LAT REAL,"
          "$COLUMN_TITLE TEXT,"
          "$COLUMN_FK_P INTEGER,"
          "FOREIGN KEY($COLUMN_FK_P) REFERENCES $TABLE_PINPOINT($COLUMN_ID)"
          ")",
        );
      },
    );
  }

  /* 
    extract pinPoints from db
   */
  Future<List<PinPoint>> getPinPoints() async {
    print("getting list of pinPoints from db");
    final Database db = await database;
    var pinPoints = await db.query(
      TABLE_PINPOINT,
      columns: [
        COLUMN_ID,
        COLUMN_IMG,
        COLUMN_LOCATION,
        COLUMN_NOTES,
        COLUMN_TITLE
      ],
    );

    List<PinPoint> listOfPinPoints = List<PinPoint>();
    pinPoints.forEach((currentPinPoint) {
      print("in db get : $currentPinPoint");
      PinPoint pinPoint = PinPoint.fromMap(currentPinPoint);
      listOfPinPoints.add(pinPoint);
    });

    return listOfPinPoints;
  }

  /* 
    extract markers from db
   */
  Future<List<InternalMarker>> getMarkers() async {
    print("getting list of pinPoints from db");
    final Database db = await database;
    var markers = await db.query(
      TABLE_MARKER,
      columns: [COLUMN_ID, COLUMN_LONG, COLUMN_LAT, COLUMN_TITLE, COLUMN_FK_P],
    );

    List<InternalMarker> listOfMarkers = List<InternalMarker>();
    markers.forEach((currentMarker) {
      InternalMarker marker = InternalMarker.fromMap(currentMarker);
      listOfMarkers.add(marker);
    });

    return listOfMarkers;
  }

  /* 
    when you insert the pinpoint or marker you need to insert both. Since the one cannot exist without the other
  */
  Future<SharedDataTuple> insert(
      PinPoint pinPoint, InternalMarker marker) async {
    print("Inserting into db");
    final Database db = await database;

    pinPoint.id = await db.insert(TABLE_PINPOINT, pinPoint.toMap());
    marker.pinPointId = pinPoint.id;
    print("in db marker: ${marker.toMap()}");
    marker.id = await db.insert(TABLE_MARKER, marker.toMap());
    return SharedDataTuple(pinPoint, marker);
  }

  // will only update marker table if its the title that is being updated.
  Future<int> update(
      PinPoint pinPoint, InternalMarker marker, bool editMarkerTable) async {
    final Database db = await database;

    if (editMarkerTable) {
      await db.update(
        TABLE_MARKER,
        marker.toMap(),
        where: "$COLUMN_FK_P = ?",
        whereArgs: [pinPoint.id],
      );
    }
    return await db.update(
      TABLE_PINPOINT,
      pinPoint.toMap(),
      where: "$COLUMN_ID = ?",
      whereArgs: [pinPoint.id],
    );
  }

  /* 
    when you delete the pinpoint or marker you need to delete both. Since the one cannot exist without the other
    FIXME: only allow id to be id of pinPoint 
  */
  Future<int> delete(int id) async {
    final Database db = await database;

    await db.delete(
      TABLE_MARKER,
      where: "$COLUMN_FK_P = ?",
      whereArgs: [id],
    );
    return await db.delete(
      TABLE_PINPOINT,
      where: "$COLUMN_ID = ?",
      whereArgs: [id],
    );
  }
}
