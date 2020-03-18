import 'package:ads_url_test/Presentation/Hot_List/hotList.dart';
import 'package:ads_url_test/Presentation/SearchPage/searchPage.dart';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Ads & Url',
            style: TextStyle(
                color: Colors.teal,
                fontSize: 20.0,
                fontWeight: FontWeight.w600),
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchPage()));
              },
              icon: Icon(
                Icons.search,
                color: Colors.teal,
              ),
            ),
          ],
          centerTitle: true,
          bottom: TabBar(
              labelPadding: EdgeInsets.all(5.0),
              indicatorColor: Colors.tealAccent,
              tabs: <Widget>[
                Text(
                  "Hot",
                  style: TextStyle(
                      color: Colors.teal,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  "New",
                  style: TextStyle(
                      color: Colors.teal,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600),
                )
              ]),
        ),
        body: TabBarView(children: <Widget>[HotList(), Text('data2')]),
      ),
    );
  }
}
