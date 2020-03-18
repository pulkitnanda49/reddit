import 'package:ads_url_test/core/failures/failure.dart';
import 'package:ads_url_test/model/list_item_model.dart';
import 'package:ads_url_test/repository/repository.dart';
import 'package:ads_url_test/sl.dart';
import 'package:dartz/dartz.dart' as d;
import 'package:flutter/material.dart';

class NewList extends StatefulWidget {
  @override
  _NewListState createState() => _NewListState();
}

class _NewListState extends State<NewList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: sl<Repository>().getNewList(),
      builder: (BuildContext context,
          AsyncSnapshot<d.Either<Failure, List<ListItemModel>>> snapshot) {
        if (snapshot.hasData) {
          return snapshot.data.fold(
            (l) => Text(l.message),
            (r) {
              print(r);
              return ListView.builder(
                shrinkWrap: true,
                itemCount: r.length,
                itemBuilder: (content, index) {
                  final item = r[index];
                  return ListTile(
                    title: Text(item.title),
                    subtitle: Text("${item.subReddit}"),
                    // trailing: item.thumbnailUrl != null
                    //     ? Image.network(item.thumbnailUrl)
                    //     : Container(),
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
