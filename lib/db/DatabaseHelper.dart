import 'dart:async';
import 'dart:io';
import 'package:movie_app_flutter/db/MovieModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  static Database _db;
  final String favoriteTable = "favorite";
  final String columnMoviePoster = "moviePoster";
  final String columnMovieId = "movieId";

  factory DatabaseHelper() => _instance;

  DatabaseHelper.internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  Future<Database> initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "userdb.db");
    var myDb = await openDatabase(path, version: 1, onCreate: _onDbCreate);
    return myDb;
  }

  void _onDbCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $favoriteTable($columnMovieId INTEGER PRIMARY KEY, $columnMoviePoster TEXT)");
  }

  Future<int> addFav(int movieId, String backdrop_path) async {
    print("idd insert" + movieId.toString());
    var dbClient = await db;
    var movieModel = MovieModel(movieId, backdrop_path);
    var res = await dbClient.insert(favoriteTable, movieModel.toMap());
  }

  Future<List> getAllFav() async {
    var dbClient = await db;
    var res = await dbClient.rawQuery("select * from $favoriteTable");
    return res.toList();
  }

  Future<int> deleteFav(int movieId) async {
    print("idd delete" + movieId.toString());
    var dbClient = await db;
    dbClient.rawQuery("DELETE FROM $favoriteTable WHERE $columnMovieId = $movieId");
  }

  Future<bool> isMovieFav(int movieId) async{
    var dbClient = await db;
    var res = await dbClient.rawQuery("SELECT * from $favoriteTable where $columnMovieId = $movieId");
    return res.length > 0;
  }
}
