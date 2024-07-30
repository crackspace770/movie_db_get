
import 'package:sqflite/sqflite.dart';

import '../../home/model/trending_response.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static Database? _database;
  static const String _tbFavorite = 'favorites';

  DatabaseHelper._internal() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._internal();

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/favorites.db',
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $_tbFavorite (
          id TEXT PRIMARY KEY,
          name TEXT,
          original_name TEXT,
          overview TEXT,
          poster_path TEXT,
          media_type TEXT,
          release_date TEXT,
          vote_average DOUBLE,
          first_air_date TEXT,
          adult INTEGER
        )''');
      },
      version: 2, // Incremented version number
    );
    return db;
  }


  Future<Database?> get database async {
    _database ??= await _initializeDb();
    return _database;
  }

  Future<void> insertFavorite(Trending trending) async {
    final db = await database;
    await db?.insert(_tbFavorite, trending.toJson());
  }

  Future<List<Trending>> getFavoriteMovies() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(
      _tbFavorite,
      where: 'media_type = ?',
      whereArgs: ['movie'],
    );
    return results.map((e) => Trending.fromJson(e)).toList();
  }

  Future<List<Trending>> getFavoriteTvShows() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(
      _tbFavorite,
      where: 'media_type = ?',
      whereArgs: ['tv'],
    );
    return results.map((e) => Trending.fromJson(e)).toList();
  }

  Future<Map> getFavoriteById(String id) async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(
      _tbFavorite,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return {};
    }
  }

  Future<void> removeFavorite(String id) async {
    final db = await database;
    await db!.delete(
      _tbFavorite,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
