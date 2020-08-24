import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/pin_point_model.dart';

class DatabaseHelper {
  static const String DATABASE = "pinPointDB.db";
  static const String TABLE_PINPOINT = 'pinPoint';
  static const String COLUMN_ID =
      '_id'; //FIXME: SHOULD ID BE INTEGER AS PRIMARY KEY?
  static const String COLUMN_TITLE = 'title';
  static const String COLUMN_LOCATION = 'location';
  static const String COLUMN_NOTES = 'notes';
  static const String COLUMN_IMG = 'img';

  // makes it a singleton class
  DatabaseHelper._();
  // we access the database from this db object
  static final DatabaseHelper db = DatabaseHelper._();

  Database _database;

  Future<Database> get database async {
    print("db called");
    if (_database != null) {
      return _database;
    }
    //create the database if it doesn't exist
    _database = await _initializeDatabase();

    return _database;
  }

  Future<Database> _initializeDatabase() async {
    // gets the db path on android or ios
    String dbPath = await getDatabasesPath();

    return await openDatabase(
      join(dbPath, DATABASE),
      version: 1,
      onCreate: (Database database, int version) async {
        print("init pinPoint table in db");
        await database.execute(
          "CREATE TABLE $TABLE_PINPOINT ("
          "$COLUMN_ID TEXT PRIMARY KEY,"
          "$COLUMN_LOCATION TEXT,"
          "$COLUMN_TITLE TEXT,"
          "$COLUMN_NOTES TEXT,"
          "$COLUMN_IMG TEXT"
          ")",
        );
      },
    );
  }

  Future<List<PinPoint>> getPinPoints() async {
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
    pinPoints.forEach((item) {
      PinPoint pinPoint = PinPoint.fromMap(item);
    });

    return listOfPinPoints;
  }

  Future<PinPoint> insert(PinPoint pinPoint) async {
    final Database db = await database;
    //FIXME: ignore return id until we use int as primary key id :D
    await db.insert(TABLE_PINPOINT, pinPoint.toMap());
    return pinPoint;
  }
}
