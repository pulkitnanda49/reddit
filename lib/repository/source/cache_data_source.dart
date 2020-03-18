import 'package:meta/meta.dart';
import 'package:ads_url_test/core/database/database.dart';
import 'package:ads_url_test/core/failures/exceptions.dart';
import 'package:ads_url_test/model/list_item_model.dart';

class CacheDataSource {
  final DataBase db;

  CacheDataSource({@required this.db}) : assert(db != null);

  Future<List<ListItemModel>> getHotList() async {
    try {
      final response = await db.getHotList();
      final result = response
          .map(
            (item) => ListItemModel.fromJson(item),
          )
          .toList();
      return result;
    } on Exception {
      throw CacheException();
    }
  }

  Future<List<ListItemModel>> getNewList() async {
    try {
      final response = await db.getNewList();
      final result = response
          .map(
            (item) => ListItemModel.fromJson(item),
          )
          .toList();
      return result;
    } on Exception {
      throw CacheException();
    }
  }

  Future<int> saveHotListItem(
      {String title, String authorName, String subreddit}) async {
    try {
      final response = await db.saveHotListItem(title, authorName, subreddit);
      print(response);
      return response;
    } on Exception {
      throw CacheException();
    }
  }

  Future<int> saveNewListItem(
      {String title, String authorName, String subreddit}) async {
    try {
      final response = await db.saveNewListItem(title, authorName, subreddit);
      return response;
    } on Exception {
      throw CacheException();
    }
  }

  Future<List<ListItemModel>> searchHotList(String title) async {
    try {
      final response = await db.searchHotList(title: title);
      final result = response
          .map(
            (item) => ListItemModel.fromJson(item),
          )
          .toList();
      return result;
    } on Exception {
      throw CacheException();
    }
  }

  Future<List<ListItemModel>> searchNewList(String title) async {
    try {
      final response = await db.searchNewList(title: title);
      final result = response
          .map(
            (item) => ListItemModel.fromJson(item),
          )
          .toList();
      return result;
    } on Exception {
      throw CacheException();
    }
  }

  Future<void> deleteHotList() async {
    await db.deleteHotList();
  }

  Future<void> deleteNewList() async {
    await db.deleteNewList();
  }
}
