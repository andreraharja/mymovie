import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:mymovie/app/data/data_movie_model.dart';
import 'package:mymovie/app/data/local/db_movie.dart';

class DbHelper {
  static DbHelper? _dbHelper;
  static Database? _database;
  DbHelper._createObject();

  factory DbHelper() {
    if (_dbHelper == null) {
      _dbHelper = DbHelper._createObject();
    }
    return _dbHelper!;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initDb();
    }
    return _database!;
  }

  final tables = [DBMovie.createTable];

  Future<Database> initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'movie.db';
    var todoDatabase = openDatabase(path, onCreate: (db, version) {
      tables.forEach((table) async {
        await db.execute(table).then((value) {
          print("Success");
        }).catchError((err) {
          print("Error : ${err.toString()}");
        });
      });
      print('Table Created');
    }, version: 1);
    return todoDatabase;
  }

  Future<String> getDownloadPath() async {
    Directory? directory;
    directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<int> insert(String table, Map<String, dynamic> data) async {
    Database db = await this.database;
    var count =
        db.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
    return count;
  }

  Future<List<DataMovie>> localDataMovie() async {
    Database db = await this.database;
    var result = await db.query(DBMovie.tableName);
    int count = result.length;
    List<DataMovie> lsResult = [];
    for (int i = 0; i < count; i++) {
      lsResult.add(DataMovie.fromLocaltoJson(result[i]));
    }
    return lsResult;
  }
}
