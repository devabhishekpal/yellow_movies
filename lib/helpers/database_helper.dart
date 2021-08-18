import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {

  static Future database() async{
    final dbPath = await getDatabasesPath();
    
    return openDatabase(join(dbPath, 'movie_database.db'),
      onCreate: (database, version){
        return database.execute('CREATE TABLE movies(id INTEGER PRIMARY KEY, name TEXT, director TEXT, posterPath TEXT)');
      }, version: 1);
  }

  static Future<List<Map<String, dynamic>>> getMoviesFromDB() async{
    final database = await DatabaseHelper.database();
    return database.query("movies", orderBy: "id DESC");
  }

  static Future insert(Map<String, Object> data) async{
    final database = await DatabaseHelper.database();
    database.insert("movies", data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future delete(int id) async {
    final database = await DatabaseHelper.database();
    return database.delete('movies', where: 'id = ?', whereArgs: [id]);
  }
}