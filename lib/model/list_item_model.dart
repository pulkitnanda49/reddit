import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

class ListItemModel extends Equatable {
  final String title;
  final String authorName;
  final DateTime created;
  final String subReddit;

  ListItemModel({
    @required this.title,
    @required this.authorName,
    @required this.created,
    @required this.subReddit,
  });

  factory ListItemModel.fromJson(Map<String, dynamic> jsonData) {
    return ListItemModel(
      title: jsonData["title"],
      authorName: jsonData["author_fullname"],
      created: DateTime.fromMillisecondsSinceEpoch(
        (jsonData["created"] as double)?.toInt() ?? 0,
      ),
      subReddit: jsonData["subreddit"],
    );
  }

  @override
  List<Object> get props => [title, authorName, created, subReddit];

  @override
  String toString() {
    // TODO: implement toString
    return "$title $authorName";
  }
}
