import 'package:ads_url_test/core/database/database.dart';
import 'package:ads_url_test/model/list_item_model.dart';
import 'package:ads_url_test/repository/source/cache_data_source.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController;
  DataBase db = new DataBase();

  @override
  Widget build(BuildContext context) {
    CacheDataSource cacheDataSource = CacheDataSource(db: db);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1.0,
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.tealAccent),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: TextFormField(
          controller: searchController,
          decoration: InputDecoration(
              hintText: 'Search..',
              border: UnderlineInputBorder(borderSide: BorderSide.none)),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.tealAccent,
              ),
              onPressed: () {
                cacheDataSource.searchHotList(searchController.toString());
              })
        ],
        centerTitle: true,
      ),
      body: ListView.builder(itemBuilder: (context, index) {
        return ListTile(
          title: Text(""),
        );
      }),
    );
  }

  Widget buildSuggestions(BuildContext context) {
    final List<ListItemModel> items = new List();

    final suggestion = searchController.toString().isEmpty
        ? items
        : items
            .where((target) =>
                target.title.startsWith(searchController.toString()))
            .toList();
    if (items.isEmpty) {
      print("Null");
    }
    return ListView.builder(
      itemBuilder: (context, position) => ListTile(
        title: Text(items[position].title),
      ),
      itemCount: suggestion.length,
    );
  }
}
