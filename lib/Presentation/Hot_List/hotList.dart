import 'package:ads_url_test/core/failures/failure.dart';
import 'package:ads_url_test/model/list_item_model.dart';
import 'package:ads_url_test/repository/repository.dart';
import 'package:ads_url_test/sl.dart';
import 'package:dartz/dartz.dart' as d;
import 'package:flutter/material.dart';

class HotList extends StatefulWidget {
  @override
  _HotListState createState() => _HotListState();
}

class _HotListState extends State<HotList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: sl<Repository>().getHotList(),
      builder: (BuildContext context,
          AsyncSnapshot<d.Either<Failure, List<ListItemModel>>> snapshot) {
        if (snapshot.hasData) {
          return snapshot.data.fold(
            (l) => Text(l.message),
            (r) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: r.length,
                itemBuilder: (content, index) {
                  final item = r[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "${item.subReddit}".toUpperCase(),
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500),
                              ),
                              Flexible(
                                child: Text(
                                  "${item.created}",
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 12.0),
                                ),
                              ),
                            ],
                          ),
                          subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 2.0),
                                child: Text(
                                  item.title,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    "Author: ",
                                    style: TextStyle(color: Colors.black87),
                                  ),
                                  Text(
                                    item.authorName,
                                    style: TextStyle(color: Colors.black45),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Divider(),
                      ],
                    ),
                  );
                },
              );
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
