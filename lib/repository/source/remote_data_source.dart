import 'dart:convert';

import 'package:ads_url_test/core/failures/exceptions.dart';
import 'package:ads_url_test/model/list_item_model.dart';
import 'package:http/http.dart';

class RemoteDataSource {
  final Client client;

  RemoteDataSource(this.client) : assert(client != null);

  Future<List<ListItemModel>> getHotList() async {
    final url = "https://www.reddit.com/hot.json";

    try {
      final response = await client.get(url);
      final jsonData = jsonDecode(response.body);
      final result = (jsonData["data"]["children"] as List)
          .map(
            (item) => ListItemModel.fromJson(item["data"]),
          )
          .toList();
      return result;
    } on Exception {
      throw ServerException();
    }
  }

  Future<List<ListItemModel>> getNewList() async {
    final url = "https://www.reddit.com/new.json";

    try {
      final response = await client.get(url);
      final jsonData = jsonDecode(response.body);
      final result = (jsonData["data"]["children"] as List)
          .map(
            (item) => ListItemModel.fromJson(item["data"]),
          )
          .toList();
      return result;
    } on Exception {
      throw ServerException();
    }
  }
}
