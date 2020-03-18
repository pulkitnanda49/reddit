import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DataBase {
  Database _db;

  Future<String> _getPath() async {
    final _ = await getApplicationDocumentsDirectory();
    return path.join(_.path, "cache.db");
  }

  Future<void> init() async {
    final path = await _getPath();

    _db = await openDatabase(path, version: 1, onCreate: (db, i) async {
      await db.execute(
          "CREATE TABLE IF NOT EXISTS hotList (id INTEGER PRIMARY KEY, title TEXT, author_fullname TEXT, subreddit TEXT, created REAL)");
      await db.execute(
          "CREATE TABLE IF NOT EXISTS newList (id INTEGER PRIMARY KEY, title TEXT, author_fullname TEXT, subreddit TEXT, created REAL)");
    });
  }

  Database get db => _db;

  Future<int> saveHotListItem(
      String title, String authorName, String subreddit) async {
    return await db.insert("hotList", {
      "title": title,
      "author_fullname": authorName,
      "subreddit": subreddit,
    });
  }

  Future<int> saveNewListItem(
      String title, String authorName, String subreddit) async {
    return await db.insert("newList", {
      "title": title,
      "author_fullname": authorName,
      "subreddit": subreddit,
    });
  }

  Future<List<Map<String, dynamic>>> getHotList() async {
    return await db.query(
      "hotList",
      columns: ["title", "subreddit", "author_fullname"],
    );
  }

  Future<List<Map<String, dynamic>>> getNewList() async {
    return await db.query(
      "newList",
      columns: ["title", "subreddit", "author_fullname"],
    );
  }

  Future<List<Map<String, dynamic>>> searchHotList({String title}) async {
    return await db.query("hotList",
        columns: ["title"], where: "title = ?", whereArgs: [title]);
  }

  Future<List<Map<String, dynamic>>> searchNewList({String title}) async {
    return await db.query("newList",
        columns: ["title"], where: "title = ?", whereArgs: [title]);
  }

  Future<void> deleteHotList() async {
    await db.delete("hotList");
  }

  Future<void> deleteNewList() async {
    await db.delete("newList");
  }

  Future<void> close() async {
    await db.close();
  }
}
